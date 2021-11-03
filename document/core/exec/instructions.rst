.. index:: instruction, function type, store, validation
.. _exec-instr:

Instructions
------------

WebAssembly computation is performed by executing individual :ref:`instructions <syntax-instr>`.


.. index:: numeric instruction, determinism, trap, NaN, value, value type
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

Numeric instructions are defined in terms of the generic :ref:`numeric operators <exec-numeric>`.
The mapping of numeric instructions to their underlying operators is expressed by the following definition:

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{\K{i}N}(n_1,\dots,n_k) &=& \F{i}\X{op}_N(n_1,\dots,n_k) \\
   \X{op}_{\K{f}N}(z_1,\dots,z_k) &=& \F{f}\X{op}_N(z_1,\dots,z_k) \\
   \end{array}

And for :ref:`conversion operators <exec-cvtop>`:

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{cvtop}^{\sx^?}_{t_1,t_2}(c) &=& \X{cvtop}^{\sx^?}_{|t_1|,|t_2|}(c) \\
   \end{array}

Where the underlying operators are partial, the corresponding instruction will :ref:`trap <trap>` when the result is not defined.
Where the underlying operators are non-deterministic, because they may return one of multiple possible :ref:`NaN <syntax-nan>` values, so are the corresponding instructions.

.. note::
   For example, the result of instruction :math:`\I32.\ADD` applied to operands :math:`i_1, i_2`
   invokes :math:`\ADD_{\I32}(i_1, i_2)`,
   which maps to the generic :math:`\iadd_{32}(i_1, i_2)` via the above definition.
   Similarly, :math:`\I64.\TRUNC\K{\_}\F32\K{\_s}` applied to :math:`z`
   invokes :math:`\TRUNC^{\K{s}}_{\F32,\I64}(z)`,
   which maps to the generic :math:`\truncs_{32,64}(z)`.


.. _exec-const:

:math:`t\K{.}\CONST~c`
......................

1. Push the value :math:`t.\CONST~c` to the stack.

.. note::
   No formal reduction rule is required for this instruction, since |CONST| instructions already are :ref:`values <syntax-val>`.


.. _exec-unop:

:math:`t\K{.}\unop`
...................

1. Assert: due to :ref:`validation <valid-unop>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

2. Pop the value :math:`t.\CONST~c_1` from the stack.

3. If :math:`\unop_t(c_1)` is defined, then:

   a. Let :math:`c` be a possible result of computing :math:`\unop_t(c_1)`.

   b. Push the value :math:`t.\CONST~c` to the stack.

4. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~t\K{.}\unop &\stepto& (t\K{.}\CONST~c)
     & (\iff c \in \unop_t(c_1)) \\
   (t\K{.}\CONST~c_1)~t\K{.}\unop &\stepto& \TRAP
     & (\iff \unop_{t}(c_1) = \{\})
   \end{array}


.. _exec-binop:

:math:`t\K{.}\binop`
....................

1. Assert: due to :ref:`validation <valid-binop>`, two values of :ref:`value type <syntax-valtype>` :math:`t` are on the top of the stack.

2. Pop the value :math:`t.\CONST~c_2` from the stack.

3. Pop the value :math:`t.\CONST~c_1` from the stack.

4. If :math:`\binop_t(c_1, c_2)` is defined, then:

   a. Let :math:`c` be a possible result of computing :math:`\binop_t(c_1, c_2)`.

   b. Push the value :math:`t.\CONST~c` to the stack.

5. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\binop &\stepto& (t\K{.}\CONST~c)
     & (\iff c \in \binop_t(c_1,c_2)) \\
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\binop &\stepto& \TRAP
     & (\iff \binop_{t}(c_1,c2) = \{\})
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
   (t\K{.}\CONST~c_1)~t\K{.}\testop &\stepto& (\I32\K{.}\CONST~c)
     & (\iff c = \testop_t(c_1)) \\
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
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\relop &\stepto& (\I32\K{.}\CONST~c)
     & (\iff c = \relop_t(c_1,c_2)) \\
   \end{array}


.. _exec-cvtop:

:math:`t_2\K{.}\cvtop\K{\_}t_1\K{\_}\sx^?`
..........................................

1. Assert: due to :ref:`validation <valid-cvtop>`, a value of :ref:`value type <syntax-valtype>` :math:`t_1` is on the top of the stack.

2. Pop the value :math:`t_1.\CONST~c_1` from the stack.

3. If :math:`\cvtop^{\sx^?}_{t_1,t_2}(c_1)` is defined:

   a. Let :math:`c_2` be a possible result of computing :math:`\cvtop^{\sx^?}_{t_1,t_2}(c_1)`.

   b. Push the value :math:`t_2.\CONST~c_2` to the stack.

4. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t_1\K{.}\CONST~c_1)~t_2\K{.}\cvtop\K{\_}t_1\K{\_}\sx^? &\stepto& (t_2\K{.}\CONST~c_2)
     & (\iff c_2 \in \cvtop^{\sx^?}_{t_1,t_2}(c_1)) \\
   (t_1\K{.}\CONST~c_1)~t_2\K{.}\cvtop\K{\_}t_1\K{\_}\sx^? &\stepto& \TRAP
     & (\iff \cvtop^{\sx^?}_{t_1,t_2}(c_1) = \{\})
   \end{array}


.. index:: reference instructions, reference
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.null:

:math:`\REFNULL~t`
..................

1. Push the value :math:`\REFNULL~t` to the stack.

.. note::
   No formal reduction rule is required for this instruction, since the |REFNULL| instruction is already a :ref:`value <syntax-val>`.


.. _exec-ref.is_null:

:math:`\REFISNULL`
..................

1. Assert: due to :ref:`validation <valid-ref.is_null>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

2. Pop the value :math:`\val` from the stack.

3. If :math:`\val` is :math:`\REFNULL~t`, then:

   a. Push the value :math:`\I32.\CONST~1` to the stack.

4. Else:

   a. Push the value :math:`\I32.\CONST~0` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \val~\REFISNULL &\stepto& \I32.\CONST~1
     & (\iff \val = \REFNULL~t) \\
   \val~\REFISNULL &\stepto& \I32.\CONST~0
     & (\otherwise) \\
   \end{array}


.. _exec-ref.func:

:math:`\REFFUNC~x`
..................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-ref.func>`, :math:`F.\AMODULE.\MIFUNCS[x]` exists.

3. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`F.\AMODULE.\MIFUNCS[x]`.

4. Push the value :math:`\REFFUNCADDR~a` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; \REFFUNC~x &\stepto& F; \REFFUNCADDR~a
     & (\iff a = F.\AMODULE.\MIFUNCS[x]) \\
   \end{array}


.. index:: parametric instructions, value
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-parametric:

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

:math:`\SELECT~(t^\ast)^?`
..........................

1. Assert: due to :ref:`validation <valid-select>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

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
   \val_1~\val_2~(\I32\K{.}\CONST~c)~\SELECT~t^? &\stepto& \val_1
     & (\iff c \neq 0) \\
   \val_1~\val_2~(\I32\K{.}\CONST~c)~\SELECT~t^? &\stepto& \val_2
     & (\iff c = 0) \\
   \end{array}

.. note::
   In future versions of WebAssembly, |SELECT| may allow more than one value per choice.


.. index:: variable instructions, local index, global index, address, global address, global instance, store, frame, value
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

:math:`\LOCALGET~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-local.get>`, :math:`F.\ALOCALS[x]` exists.

3. Let :math:`\val` be the value :math:`F.\ALOCALS[x]`.

4. Push the value :math:`\val` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\LOCALGET~x) &\stepto& F; \val
     & (\iff F.\ALOCALS[x] = \val) \\
   \end{array}


.. _exec-local.set:

:math:`\LOCALSET~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-local.set>`, :math:`F.\ALOCALS[x]` exists.

3. Assert: due to :ref:`validation <valid-local.set>`, a value is on the top of the stack.

4. Pop the value :math:`\val` from the stack.

5. Replace :math:`F.\ALOCALS[x]` with the value :math:`\val`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; \val~(\LOCALSET~x) &\stepto& F'; \epsilon
     & (\iff F' = F \with \ALOCALS[x] = \val) \\
   \end{array}


.. _exec-local.tee:

:math:`\LOCALTEE~x`
...................

1. Assert: due to :ref:`validation <valid-local.tee>`, a value is on the top of the stack.

2. Pop the value :math:`\val` from the stack.

3. Push the value :math:`\val` to the stack.

4. Push the value :math:`\val` to the stack.

5. :ref:`Execute <exec-local.set>` the instruction :math:`(\LOCALSET~x)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \val~(\LOCALTEE~x) &\stepto& \val~\val~(\LOCALSET~x)
   \end{array}


.. _exec-global.get:

:math:`\GLOBALGET~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-global.get>`, :math:`F.\AMODULE.\MIGLOBALS[x]` exists.

3. Let :math:`a` be the :ref:`global address <syntax-globaladdr>` :math:`F.\AMODULE.\MIGLOBALS[x]`.

4. Assert: due to :ref:`validation <valid-global.get>`, :math:`S.\SGLOBALS[a]` exists.

5. Let :math:`\X{glob}` be the :ref:`global instance <syntax-globalinst>` :math:`S.\SGLOBALS[a]`.

6. Let :math:`\val` be the value :math:`\X{glob}.\GIVALUE`.

7. Push the value :math:`\val` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\GLOBALGET~x) &\stepto& S; F; \val
   \end{array}
   \\ \qquad
     (\iff S.\SGLOBALS[F.\AMODULE.\MIGLOBALS[x]].\GIVALUE = \val) \\
   \end{array}


.. _exec-global.set:

:math:`\GLOBALSET~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-global.set>`, :math:`F.\AMODULE.\MIGLOBALS[x]` exists.

3. Let :math:`a` be the :ref:`global address <syntax-globaladdr>` :math:`F.\AMODULE.\MIGLOBALS[x]`.

4. Assert: due to :ref:`validation <valid-global.set>`, :math:`S.\SGLOBALS[a]` exists.

5. Let :math:`\X{glob}` be the :ref:`global instance <syntax-globalinst>` :math:`S.\SGLOBALS[a]`.

6. Assert: due to :ref:`validation <valid-global.set>`, a value is on the top of the stack.

7. Pop the value :math:`\val` from the stack.

8. Replace :math:`\X{glob}.\GIVALUE` with the value :math:`\val`.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; \val~(\GLOBALSET~x) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
   (\iff S' = S \with \SGLOBALS[F.\AMODULE.\MIGLOBALS[x]].\GIVALUE = \val) \\
   \end{array}

.. note::
   :ref:`Validation <valid-global.set>` ensures that the global is, in fact, marked as mutable.


.. index:: table instruction, table index, store, frame, address, table address, table instance, element address, element instance, value, integer, limits, reference, reference type
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-table.get:

:math:`\TABLEGET~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.get>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`a` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.get>`, :math:`S.\STABLES[a]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[a]`.

6. Assert: due to :ref:`validation <valid-table.get>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIELEM`, then:

   a. Trap.

9. Let :math:`\val` be the value :math:`\X{tab}.\TIELEM[i]`.

10. Push the value :math:`\val` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\TABLEGET~x) &\stepto& S; F; \val
   \end{array}
   \\ \qquad
     (\iff S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM[i] = \val) \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\TABLEGET~x) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-table.set:

:math:`\TABLESET`
.................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.set>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`a` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.set>`, :math:`S.\STABLES[a]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[a]`.

6. Assert: due to :ref:`validation <valid-table.set>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

7. Pop the value :math:`\val` from the stack.

8. Assert: due to :ref:`validation <valid-table.set>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

11. Replace the element :math:`\X{tab}.\TIELEM[i]` with :math:`\val`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~\val~(\TABLESET~x) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     (\iff S' = S \with \STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM[i] = \val) \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~\val~(\TABLESET~x) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-table.size:

:math:`\TABLESIZE~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.size>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`a` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.size>`, :math:`S.\STABLES[a]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[a]`.

6. Let :math:`\X{sz}` be the length of :math:`\X{tab}.\TIELEM`.

7. Push the value :math:`\I32.\CONST~\X{sz}` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; \TABLESIZE~x &\stepto& S; F; (\I32.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     (\iff |S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM| = \X{sz}) \\
   \end{array}


.. _exec-table.grow:

:math:`\TABLEGROW~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.grow>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`a` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.grow>`, :math:`S.\STABLES[a]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[a]`.

6. Let :math:`\X{sz}` be the length of :math:`S.\STABLES[a]`.

7. Assert: due to :ref:`validation <valid-table.grow>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

8. Pop the value :math:`\I32.\CONST~n` from the stack.

9. Assert: due to :ref:`validation <valid-table.fill>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

10. Pop the value :math:`\val` from the stack.

11. Either, try :ref:`growing <grow-table>` :math:`\X{table}` by :math:`n` entries with initialization value :math:`\val`:

   a. If it succeeds, push the value :math:`\I32.\CONST~\X{sz}` to the stack.

   b. Else, push the value :math:`\I32.\CONST~(-1)` to the stack.

12. Or, push the value :math:`\I32.\CONST~(-1)` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; \val~(\I32.\CONST~n)~\TABLEGROW~x &\stepto& S'; F; (\I32.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & F.\AMODULE.\MITABLES[x] = a \\
     \wedge & \X{sz} = |S.\STABLES[a].\TIELEM| \\
     \wedge & S' = S \with \STABLES[a] = \growtable(S.\STABLES[a], n, \val)) \\[1ex]
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~n)~\TABLEGROW~x &\stepto& S; F; (\I32.\CONST~{-1})
   \end{array}
   \end{array}

.. note::
   The |TABLEGROW| instruction is non-deterministic.
   It may either succeed, returning the old table size :math:`\X{sz}`,
   or fail, returning :math:`{-1}`.
   Failure *must* occur if the referenced table instance has a maximum size defined that would be exceeded.
   However, failure *can* occur in other cases as well.
   In practice, the choice depends on the :ref:`resources <impl-exec>` available to the :ref:`embedder <embedder>`.


.. _exec-table.fill:

:math:`\TABLEFILL~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.fill>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.fill>`, :math:`S.\STABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-table.fill>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~n` from the stack.

8. Assert: due to :ref:`validation <valid-table.fill>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

9. Pop the value :math:`\val` from the stack.

10. Assert: due to :ref:`validation <valid-table.fill>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

11. Pop the value :math:`\I32.\CONST~i` from the stack.

12. If :math:`i + n` is larger than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

12. If :math:`n` is :math:`0`, then:

    a. Return.

13. Push the value :math:`\I32.\CONST~i` to the stack.

14. Push the value :math:`\val` to the stack.

15. Execute the instruction :math:`\TABLESET~x`.

16. Push the value :math:`\I32.\CONST~(i+1)` to the stack.

17. Push the value :math:`\val` to the stack.

18. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

19. Execute the instruction :math:`\TABLEFILL~x`.

.. math::
   \begin{array}{l}
   S; F; (\I32.\CONST~i)~\val~(\I32.\CONST~n)~(\TABLEFILL~x)
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i + n > |S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\I32.\CONST~i)~\val~(\I32.\CONST~0)~(\TABLEFILL~x)
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\I32.\CONST~i)~\val~(\I32.\CONST~n+1)~(\TABLEFILL~x)
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\I32.\CONST~i)~\val~(\TABLESET~x) \\
       (\I32.\CONST~i+1)~\val~(\I32.\CONST~n)~(\TABLEFILL~x) \\
       \end{array}
     \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-table.copy:

:math:`\TABLECOPY~x~y`
......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.copy>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`\X{ta}_x` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.copy>`, :math:`S.\STABLES[\X{ta}_x]` exists.

5. Let :math:`\X{tab}_x` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}_x]`.

6. Assert: due to :ref:`validation <valid-table.copy>`, :math:`F.\AMODULE.\MITABLES[y]` exists.

7. Let :math:`\X{ta}_y` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[y]`.

8. Assert: due to :ref:`validation <valid-table.copy>`, :math:`S.\STABLES[\X{ta}_y]` exists.

9. Let :math:`\X{tab}_y` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}_y]`.

10. Assert: due to :ref:`validation <valid-table.copy>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Assert: due to :ref:`validation <valid-table.copy>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

13. Pop the value :math:`\I32.\CONST~s` from the stack.

14. Assert: due to :ref:`validation <valid-table.copy>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

15. Pop the value :math:`\I32.\CONST~d` from the stack.

16. If :math:`s + n` is larger than the length of :math:`\X{tab}_y.\TIELEM` or :math:`d + n` is larger than the length of :math:`\X{tab}_x.\TIELEM`, then:

    a. Trap.

17. If :math:`n = 0`, then:

   a. Return.

18. If :math:`d \leq s`, then:

   a. Push the value :math:`\I32.\CONST~d` to the stack.

   b. Push the value :math:`\I32.\CONST~s` to the stack.

   c. Execute the instruction :math:`\TABLEGET~y`.

   d. Execute the instruction :math:`\TABLESET~x`.

   e. Assert: due to the earlier check against the table size, :math:`d+1 < 2^{32}`.

   f. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

   g. Assert: due to the earlier check against the table size, :math:`s+1 < 2^{32}`.

   h. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

19. Else:

   a. Assert: due to the earlier check against the table size, :math:`d+n-1 < 2^{32}`.

   b. Push the value :math:`\I32.\CONST~(d+n-1)` to the stack.

   c. Assert: due to the earlier check against the table size, :math:`s+n-1 < 2^{32}`.

   d. Push the value :math:`\I32.\CONST~(s+n-1)` to the stack.

   c. Execute the instruction :math:`\TABLEGET~y`.

   f. Execute the instruction :math:`\TABLESET~x`.

   g. Push the value :math:`\I32.\CONST~d` to the stack.

   h. Push the value :math:`\I32.\CONST~s` to the stack.

20. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

21. Execute the instruction :math:`\TABLECOPY~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\TABLECOPY~x~y)
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & s + n > |S.\STABLES[F.\AMODULE.\MITABLES[y]].\TIELEM| \\
      \vee & d + n > |S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~0)~(\TABLECOPY~x~y)
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\TABLECOPY~x~y)
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\I32.\CONST~d)~(\I32.\CONST~s)~(\TABLEGET~y)~(\TABLESET~x) \\
       (\I32.\CONST~d+1)~(\I32.\CONST~s+1)~(\I32.\CONST~n)~(\TABLECOPY~x~y) \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d \leq s)
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\TABLECOPY~x~y)
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\I32.\CONST~d+n-1)~(\I32.\CONST~s+n-1)~(\TABLEGET~y)~(\TABLESET~x) \\
       (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\TABLECOPY~x~y) \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d > s) \\
   \end{array}


.. _exec-table.init:

:math:`\TABLEINIT~x~y`
......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.init>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.init>`, :math:`S.\STABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-table.init>`, :math:`F.\AMODULE.\MIELEMS[y]` exists.

7. Let :math:`\X{ea}` be the :ref:`element address <syntax-elemaddr>` :math:`F.\AMODULE.\MIELEMS[y]`.

8. Assert: due to :ref:`validation <valid-table.init>`, :math:`S.\SELEMS[\X{ea}]` exists.

9. Let :math:`\X{elem}` be the :ref:`element instance <syntax-eleminst>` :math:`S.\SELEMS[\X{ea}]`.

10. Assert: due to :ref:`validation <valid-table.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Assert: due to :ref:`validation <valid-table.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

13. Pop the value :math:`\I32.\CONST~s` from the stack.

14. Assert: due to :ref:`validation <valid-table.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

15. Pop the value :math:`\I32.\CONST~d` from the stack.

16. If :math:`s + n` is larger than the length of :math:`\X{elem}.\EIELEM` or :math:`d + n` is larger than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

17. If :math:`n = 0`, then:

    a. Return.

18. Let :math:`\val` be the :ref:`reference value <syntax-ref>` :math:`\X{elem}.\EIELEM[s]`.

19. Push the value :math:`\I32.\CONST~d` to the stack.

20. Push the value :math:`\val` to the stack.

21. Execute the instruction :math:`\TABLESET~x`.

22. Assert: due to the earlier check against the table size, :math:`d+1 < 2^{32}`.

23. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

24. Assert: due to the earlier check against the segment size, :math:`s+1 < 2^{32}`.

25. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

26. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

27. Execute the instruction :math:`\TABLEINIT~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\TABLEINIT~x~y)
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & s + n > |S.\SELEMS[F.\AMODULE.\MIELEMS[y]].\EIELEM| \\
      \vee & d + n > |S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~0)~(\TABLEINIT~x~y)
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\TABLEINIT~x~y)
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\I32.\CONST~d)~\val~(\TABLESET~x) \\
       (\I32.\CONST~d+1)~(\I32.\CONST~s+1)~(\I32.\CONST~n)~(\TABLEINIT~x~y) \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff \val = S.\SELEMS[F.\AMODULE.\MIELEMS[y]].\EIELEM[s]) \\
   \end{array}


.. _exec-elem.drop:

:math:`\ELEMDROP~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-elem.drop>`, :math:`F.\AMODULE.\MIELEMS[x]` exists.

3. Let :math:`a` be the :ref:`element address <syntax-elemaddr>` :math:`F.\AMODULE.\MIELEMS[x]`.

4. Assert: due to :ref:`validation <valid-elem.drop>`, :math:`S.\SELEMS[a]` exists.

5. Replace :math:`S.\SELEMS[a]` with the :ref:`element instance <syntax-eleminst>` :math:`\{\EIELEM~\epsilon\}`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\ELEMDROP~x) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     (\iff S' = S \with \SELEMS[F.\AMODULE.\MIELEMS[x]] = \{ \EIELEM~\epsilon \}) \\
   \end{array}


.. index:: memory instruction, memory index, store, frame, address, memory address, memory instance, value, integer, limits, value type, bit width
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-memarg:
.. _exec-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. note::
   The alignment :math:`\memarg.\ALIGN` in load and store instructions does not affect the semantics.
   It is an indication that the offset :math:`\X{ea}` at which the memory is accessed is intended to satisfy the property :math:`\X{ea} \mod 2^{\memarg.\ALIGN} = 0`.
   A WebAssembly implementation can use this hint to optimize for the intended use.
   Unaligned access violating that property is still allowed and must succeed regardless of the annotation.
   However, it may be substantially slower on some hardware.


.. _exec-load:
.. _exec-loadn:

:math:`t\K{.}\LOAD~\memarg` and :math:`t\K{.}\LOAD{N}\K{\_}\sx~\memarg`
.......................................................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-loadn>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-loadn>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-loadn>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`N` is not part of the instruction, then:

   a. Let :math:`N` be the :ref:`bit width <syntax-valtype>` :math:`|t|` of :ref:`value type <syntax-valtype>` :math:`t`.

10. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

11. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIDATA[\X{ea} \slice N/8]`.

12. If :math:`N` and :math:`\sx` are part of the instruction, then:

    a. Let :math:`n` be the integer for which :math:`\bytes_{\iN}(n) = b^\ast`.

    b. Let :math:`c` be the result of computing :math:`\extend^{\sx}_{N,|t|}(n)`.

13. Else:

    a. Let :math:`c` be the constant for which :math:`\bytes_t(c) = b^\ast`.

14. Push the value :math:`t.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(t.\LOAD~\memarg) &\stepto& S; F; (t.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + |t|/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA| \\
     \wedge & \bytes_t(c) = S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA[\X{ea} \slice |t|/8])
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(t.\LOAD{N}\K{\_}\sx~\memarg) &\stepto&
     S; F; (t.\CONST~\extend^{\sx}_{N,|t|}(n))
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA| \\
     \wedge & \bytes_{\iN}(n) = S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA[\X{ea} \slice N/8])
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~k)~(t.\LOAD({N}\K{\_}\sx)^?~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-store:
.. _exec-storen:

:math:`t\K{.}\STORE~\memarg` and :math:`t\K{.}\STORE{N}~\memarg`
................................................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-storen>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-storen>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-storen>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

7. Pop the value :math:`t.\CONST~c` from the stack.

8. Assert: due to :ref:`validation <valid-storen>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

11. If :math:`N` is not part of the instruction, then:

    a. Let :math:`N` be the :ref:`bit width <syntax-valtype>` :math:`|t|` of :ref:`value type <syntax-valtype>` :math:`t`.

12. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

13. If :math:`N` is part of the instruction, then:

    a. Let :math:`n` be the result of computing :math:`\wrap_{|t|,N}(c)`.

    b. Let :math:`b^\ast` be the byte sequence :math:`\bytes_{\iN}(n)`.

14. Else:

    a. Let :math:`b^\ast` be the byte sequence :math:`\bytes_t(c)`.

15. Replace the bytes :math:`\X{mem}.\MIDATA[\X{ea} \slice N/8]` with :math:`b^\ast`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(t.\CONST~c)~(t.\STORE~\memarg) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + |t|/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA| \\
     \wedge & S' = S \with \SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA[\X{ea} \slice |t|/8] = \bytes_t(c))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(t.\CONST~c)~(t.\STORE{N}~\memarg) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA| \\
     \wedge & S' = S \with \SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA[\X{ea} \slice N/8] = \bytes_{\iN}(\wrap_{|t|,N}(c))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~k)~(t.\CONST~c)~(t.\STORE{N}^?~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-memory.size:

:math:`\MEMORYSIZE`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.size>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-memory.size>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Let :math:`\X{sz}` be the length of :math:`\X{mem}.\MIDATA` divided by the :ref:`page size <page-size>`.

7. Push the value :math:`\I32.\CONST~\X{sz}` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; \MEMORYSIZE &\stepto& S; F; (\I32.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     (\iff |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA| = \X{sz}\cdot64\,\F{Ki}) \\
   \end{array}


.. _exec-memory.grow:

:math:`\MEMORYGROW`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.grow>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-memory.grow>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Let :math:`\X{sz}` be the length of :math:`S.\SMEMS[a]` divided by the :ref:`page size <page-size>`.

7. Assert: due to :ref:`validation <valid-memory.grow>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

8. Pop the value :math:`\I32.\CONST~n` from the stack.

9. Let :math:`\X{err}` be the |i32| value :math:`2^{32}-1`, for which :math:`\signed_{32}(\X{err})` is :math:`-1`.

10. Either, try :ref:`growing <grow-mem>` :math:`\X{mem}` by :math:`n` :ref:`pages <page-size>`:

   a. If it succeeds, push the value :math:`\I32.\CONST~\X{sz}` to the stack.

   b. Else, push the value :math:`\I32.\CONST~\X{err}` to the stack.

11. Or, push the value :math:`\I32.\CONST~\X{err}` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~n)~\MEMORYGROW &\stepto& S'; F; (\I32.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & F.\AMODULE.\MIMEMS[0] = a \\
     \wedge & \X{sz} = |S.\SMEMS[a].\MIDATA|/64\,\F{Ki} \\
     \wedge & S' = S \with \SMEMS[a] = \growmem(S.\SMEMS[a], n)) \\
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~n)~\MEMORYGROW &\stepto& S; F; (\I32.\CONST~\signed_{32}^{-1}(-1))
   \end{array}
   \end{array}

.. note::
   The |MEMORYGROW| instruction is non-deterministic.
   It may either succeed, returning the old memory size :math:`\X{sz}`,
   or fail, returning :math:`{-1}`.
   Failure *must* occur if the referenced memory instance has a maximum size defined that would be exceeded.
   However, failure *can* occur in other cases as well.
   In practice, the choice depends on the :ref:`resources <impl-exec>` available to the :ref:`embedder <embedder>`.


.. _exec-memory.fill:

:math:`\MEMORYFILL`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.fill>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`\X{ma}` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-memory.fill>`, :math:`S.\SMEMS[\X{ma}]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[\X{ma}]`.

6. Assert: due to :ref:`validation <valid-memory.fill>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~n` from the stack.

8. Assert: due to :ref:`validation <valid-memory.fill>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\val` from the stack.

10. Assert: due to :ref:`validation <valid-memory.fill>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

11. Pop the value :math:`\I32.\CONST~d` from the stack.

12. If :math:`d + n` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

13. If :math:`n = 0`, then:

    a. Return.

14. Push the value :math:`\I32.\CONST~d` to the stack.

15. Push the value :math:`\val` to the stack.

16. Execute the instruction :math:`\I32\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}`.

17. Assert: due to the earlier check against the memory size, :math:`d+1 < 2^{32}`.

18. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

19. Push the value :math:`\val` to the stack.

20. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

21. Execute the instruction :math:`\MEMORYFILL`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\I32.\CONST~d)~\val~(\I32.\CONST~n)~\MEMORYFILL
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     (\iff d + n > |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA|) \\
   \\[1ex]
   S; F; (\I32.\CONST~d)~\val~(\I32.\CONST~0)~\MEMORYFILL
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\I32.\CONST~d)~\val~(\I32.\CONST~n+1)~\MEMORYFILL
     \quad\stepto\quad S; F;
       \begin{array}[t]{@{}l@{}}
       (\I32.\CONST~d)~\val~(\I32\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\I32.\CONST~d+1)~\val~(\I32.\CONST~n)~\MEMORYFILL \\
       \end{array}
     \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-memory.copy:

:math:`\MEMORYCOPY`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.copy>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`\X{ma}` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-memory.copy>`, :math:`S.\SMEMS[\X{ma}]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[\X{ma}]`.

6. Assert: due to :ref:`validation <valid-memory.copy>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~n` from the stack.

8. Assert: due to :ref:`validation <valid-memory.copy>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~s` from the stack.

10. Assert: due to :ref:`validation <valid-memory.copy>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

11. Pop the value :math:`\I32.\CONST~d` from the stack.

12. If :math:`s + n` is larger than the length of :math:`\X{mem}.\MIDATA` or :math:`d + n` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

13. If :math:`n = 0`, then:

   a. Return.

14. If :math:`d \leq s`, then:

   a. Push the value :math:`\I32.\CONST~d` to the stack.

   b. Push the value :math:`\I32.\CONST~s` to the stack.

   c. Execute the instruction :math:`\I32\K{.}\LOAD\K{8\_u}~\{ \OFFSET~0, \ALIGN~0 \}`.

   d. Execute the instruction :math:`\I32\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}`.

   e. Assert: due to the earlier check against the memory size, :math:`d+1 < 2^{32}`.

   f. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

   g. Assert: due to the earlier check against the memory size, :math:`s+1 < 2^{32}`.

   h. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

15. Else:

   a. Assert: due to the earlier check against the memory size, :math:`d+n-1 < 2^{32}`.

   b. Push the value :math:`\I32.\CONST~(d+n-1)` to the stack.

   c. Assert: due to the earlier check against the memory size, :math:`s+n-1 < 2^{32}`.

   d. Push the value :math:`\I32.\CONST~(s+n-1)` to the stack.

   e. Execute the instruction :math:`\I32\K{.}\LOAD\K{8\_u}~\{ \OFFSET~0, \ALIGN~0 \}`.

   f. Execute the instruction :math:`\I32\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}`.

   g. Push the value :math:`\I32.\CONST~d` to the stack.

   h. Push the value :math:`\I32.\CONST~s` to the stack.

16. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

17. Execute the instruction :math:`\MEMORYCOPY`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~\MEMORYCOPY
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & s + n > |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA| \\
      \vee & d + n > |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~0)~\MEMORYCOPY
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~\MEMORYCOPY
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\I32.\CONST~d) \\
       (\I32.\CONST~s)~(\I32\K{.}\LOAD\K{8\_u}~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\I32\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\I32.\CONST~d+1)~(\I32.\CONST~s+1)~(\I32.\CONST~n)~\MEMORYCOPY \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d \leq s)
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~\MEMORYCOPY
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\I32.\CONST~d+n-1) \\
       (\I32.\CONST~s+n-1)~(\I32\K{.}\LOAD\K{8\_u}~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\I32\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~\MEMORYCOPY \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d > s) \\
   \end{array}


.. _exec-memory.init:

:math:`\MEMORYINIT~x`
.....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.init>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`\X{ma}` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-memory.init>`, :math:`S.\SMEMS[\X{ma}]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[\X{ma}]`.

6. Assert: due to :ref:`validation <valid-memory.init>`, :math:`F.\AMODULE.\MIDATAS[x]` exists.

7. Let :math:`\X{da}` be the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[x]`.

8. Assert: due to :ref:`validation <valid-memory.init>`, :math:`S.\SDATAS[\X{da}]` exists.

9. Let :math:`\X{data}` be the  :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]`.

10. Assert: due to :ref:`validation <valid-memory.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Assert: due to :ref:`validation <valid-memory.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

13. Pop the value :math:`\I32.\CONST~s` from the stack.

14. Assert: due to :ref:`validation <valid-memory.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

15. Pop the value :math:`\I32.\CONST~d` from the stack.

16. If :math:`s + n` is larger than the length of :math:`\X{data}.\DIDATA` or :math:`d + n` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

17. If :math:`n = 0`, then:

    a. Return.

18. Let :math:`b` be the byte :math:`\X{data}.\DIDATA[s]`.

19. Push the value :math:`\I32.\CONST~d` to the stack.

20. Push the value :math:`\I32.\CONST~b` to the stack.

21. Execute the instruction :math:`\I32\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}`.

22. Assert: due to the earlier check against the memory size, :math:`d+1 < 2^{32}`.

23. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

24. Assert: due to the earlier check against the memory size, :math:`s+1 < 2^{32}`.

25. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

26. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

27. Execute the instruction :math:`\MEMORYINIT~x`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\MEMORYINIT~x)
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & s + n > |S.\SDATAS[F.\AMODULE.\MIDATAS[x]].\DIDATA| \\
      \vee & d + n > |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~0)~(\MEMORYINIT~x)
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\MEMORYINIT~x)
     \quad\stepto
       \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\I32.\CONST~d)~(\I32.\CONST~b)~(\I32\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\I32.\CONST~d+1)~(\I32.\CONST~s+1)~(\I32.\CONST~n)~(\MEMORYINIT~x) \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff b = S.\SDATAS[F.\AMODULE.\MIDATAS[x]].\DIDATA[s]) \\
   \end{array}


.. _exec-data.drop:

:math:`\DATADROP~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-data.drop>`, :math:`F.\AMODULE.\MIDATAS[x]` exists.

3. Let :math:`a` be the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[x]`.

4. Assert: due to :ref:`validation <valid-data.drop>`, :math:`S.\SDATAS[a]` exists.

5. Replace :math:`S.\SDATAS[a]` with the :ref:`data instance <syntax-datainst>` :math:`\{\DIDATA~\epsilon\}`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\DATADROP~x) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     (\iff S' = S \with \SDATAS[F.\AMODULE.\MIDATAS[x]] = \{ \DIDATA~\epsilon \}) \\
   \end{array}


.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, type index, vector, address, table address, table instance, store, frame
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-label:
.. _exec-instr-control:

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

:math:`\BLOCK~\blocktype~\instr^\ast~\END`
..........................................

1. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\expand_F(\blocktype)` is defined.

2. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`function type <syntax-functype>` :math:`\expand_F(\blocktype)`.

3. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the block.

4. Assert: due to :ref:`validation <valid-block>`, there are at least :math:`m` values on the top of the stack.

5. Pop the values :math:`\val^m` from the stack.

6. :ref:`Enter <exec-instr-seq-enter>` the block :math:`\val^m~\instr^\ast` with label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl}
   F; \val^m~\BLOCK~\X{bt}~\instr^\ast~\END &\stepto&
     F; \LABEL_n\{\epsilon\}~\val^m~\instr^\ast~\END
     \\&&\quad (\iff \expand_F(\X{bt}) = [t_1^m] \to [t_2^n])
   \end{array}


.. _exec-loop:

:math:`\LOOP~\blocktype~\instr^\ast~\END`
.........................................

1. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\expand_F(\blocktype)` is defined.

2. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`function type <syntax-functype>` :math:`\expand_F(\blocktype)`.

3. Let :math:`L` be the label whose arity is :math:`m` and whose continuation is the start of the loop.

4. Assert: due to :ref:`validation <valid-loop>`, there are at least :math:`m` values on the top of the stack.

5. Pop the values :math:`\val^m` from the stack.

6. :ref:`Enter <exec-instr-seq-enter>` the block :math:`\val^m~\instr^\ast` with label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl}
   F; \val^m~\LOOP~\X{bt}~\instr^\ast~\END &\stepto&
     F; \LABEL_m\{\LOOP~\X{bt}~\instr^\ast~\END\}~\val^m~\instr^\ast~\END
     \\&&\quad (\iff \expand_F(\X{bt}) = [t_1^m] \to [t_2^n])
   \end{array}


.. _exec-if:

:math:`\IF~\blocktype~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
.............................................................

1. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\expand_F(\blocktype)` is defined.

2. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`function type <syntax-functype>` :math:`\expand_F(\blocktype)`.

3. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the |IF| instruction.

4. Assert: due to :ref:`validation <valid-if>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

5. Pop the value :math:`\I32.\CONST~c` from the stack.

6. Assert: due to :ref:`validation <valid-if>`, there are at least :math:`m` values on the top of the stack.

7. Pop the values :math:`\val^m` from the stack.

8. If :math:`c` is non-zero, then:

   a. :ref:`Enter <exec-instr-seq-enter>` the block :math:`\val^m~\instr_1^\ast` with label :math:`L`.

9. Else:

   a. :ref:`Enter <exec-instr-seq-enter>` the block :math:`\val^m~\instr_2^\ast` with label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl}
   F; \val^m~(\I32.\CONST~c)~\IF~\X{bt}~\instr_1^\ast~\ELSE~\instr_2^\ast~\END &\stepto&
     F; \LABEL_n\{\epsilon\}~\val^m~\instr_1^\ast~\END
     \\&&\quad (\iff c \neq 0 \wedge \expand_F(\X{bt}) = [t_1^m] \to [t_2^n]) \\
   F; \val^m~(\I32.\CONST~c)~\IF~\X{bt}~\instr_1^\ast~\ELSE~\instr_2^\ast~\END &\stepto&
     F; \LABEL_n\{\epsilon\}~\val^m~\instr_2^\ast~\END
     \\&&\quad (\iff c = 0 \wedge \expand_F(\X{bt}) = [t_1^m] \to [t_2^n]) \\
   \end{array}


.. _exec-try:

:math:`\TRY~\blocktype~\instr_1^\ast~\CATCH~\instr_2^\ast~\END`
...............................................................

1. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\expand_F(\blocktype)` is defined.

2. Let :math:`[t_1^n] \to [t_2^m]` be the :ref:`function type <syntax-functype>` :math:`\expand_F(\blocktype)`.

3. Assert: due to :ref:`validation <valid-try>`, there are at least :math:`n` values on the top of the stack.

4. Pop the values :math:`\val^n` from the stack.

5. Let :math:`L` be the label whose arity is :math:`m` and whose continuation is the end of the |TRY| instruction.

6. Let :math:`H` be the exception handler whose arity is :math:`m` and whose continuation is the beginning of :math:`\instr_2^\ast`.

7. :ref:`Enter <exec-handler-enter>` the exception handler `H`.

8. :ref:`Enter <exec-instr-seq-enter>` the block :math:`\val^n~\instr_1^\ast` with label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}}
   F; \val^n~(\TRY~\X{bt}~\instr_1^\ast~\CATCH~\instr_2^\ast~\END &\stepto&
   \CATCHN_m\{\instr_2\}~(\LABEL_m \{\}~\val^n~\instr_1^\ast~\END)~\END \\
   \hspace{5ex}(\iff \expand_F(\X{bt}) = [t_1^n] \to [t_2^m]) &&\\
   \end{array}


.. _exec-throw:

:math:`\THROW~x`
................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-throw>`, :math:`F.\AMODULE.\MIEXNS[x]` exists.

3. Let :math:`a` be the :ref:`exception address <syntax-exnaddr>` :math:`F.\AMODULE.\MIEXNS[x]`.

4. :ref:`Throw <exec-throwaddr>` an exception with :ref:`exception address <syntax-exnaddr>` :math:`a`.

.. math::
   ~\\[-1ex]
   \begin{array}{lclr@{\qquad}l}
   \THROW~x &\stepto& \THROWADDR~a & (\iff F.\AMODULE.\MIEXNS[x] = a) \\
   \end{array}


.. _exec-rethrow:

:math:`\RETHROW`
................

1. Assert: due to :ref:`validation <valid-rethrow>`, there is a value with :ref:`reference type <syntax-reftype>` :math:`\EXNREF` on top of the stack.

2. Pop the :math:`\EXNREF` value from the stack.

3. If the :math:`\EXNREF` value is :math:`\REFNULL~\EXNREF` then:

   a. Trap.

4. Assert: :math:`\EXNREF` is of the form :math:`(\REFEXNADDR~a~\val^\ast)`.

5. Put the values :math:`\val^\ast` on the stack.

6. :ref:`Throw <exec-throwaddr>`  an exception with :ref:`exception address <syntax-exnaddr>` :math:`a`.

.. math::
   ~\\[-1ex]
   \begin{array}{lclr@{\qquad}}
     (\REFNULL~\EXNREF)~\RETHROW &\stepto& \TRAP \\
     (\REFEXNADDR~a~\val^\ast)~\RETHROW &\stepto& \val^\ast~(\THROWADDR~a) \\
   \end{array}


.. _exec-br_on_exn:

:math:`\BRONEXN~l~x`
....................

1. Assert: due to :ref:`validation <valid-br_on_exn>`, there is a value with :ref:`reference type <syntax-reftype>` :math:`\EXNREF` on top of the stack.

2. Pop the :math:`\EXNREF` value from the stack.

3. If the :math:`\EXNREF` value is :math:`\REFNULL~\EXNREF` then:

   a. Trap.

4. Assert: :math:`\EXNREF` is of the form :math:`(\REFEXNADDR~a~\val^\ast)`.

5. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

6. Assert: due to :ref:`validation <valid-br_on_exn>`, :math:`F.\AMODULE.\MIEXNS[x]` exists.

7. If :math:`F.\AMODULE.\MIEXNS[x]=a`, then:

   a. Put the values :math:`\val^\ast` on the stack.

   b. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

8. Else:

   a. Put the value :math:`(\REFEXNADDR~a~\val^\ast)` back on the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{lclr@{\qquad}l}
     F; (\REFNULL~\EXNREF)~\BRONEXN~l~x &\stepto& F; \TRAP \\
     F; (\REFEXNADDR~a~\val^\ast)~\BRONEXN~l~x &\stepto& F; \val^\ast~(\BR~l)     & (\iff F.\AMODULE.\MIEXNS[x] = a) \\
     F; (\REFEXNADDR~a~\val^\ast)~\BRONEXN~l~x &\stepto& F; (\REFEXNADDR~a~\val^\ast) & (\iff F.\AMODULE.\MIEXNS[x] \neq a) \\
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
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   \LABEL_n\{\instr^\ast\}~\XB^l[\val^n~(\BR~l)]~\END &\stepto& \val^n~\instr^\ast
   \end{array}


.. _exec-br_if:

:math:`\BRIF~l`
...............

1. Assert: due to :ref:`validation <valid-br_if>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~c` from the stack.

3. If :math:`c` is non-zero, then:

   a. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

4. Else:

   a. Do nothing.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   (\I32.\CONST~c)~(\BRIF~l) &\stepto& (\BR~l)
     & (\iff c \neq 0) \\
   (\I32.\CONST~c)~(\BRIF~l) &\stepto& \epsilon
     & (\iff c = 0) \\
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
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   (\I32.\CONST~i)~(\BRTABLE~l^\ast~l_N) &\stepto& (\BR~l_i)
     & (\iff l^\ast[i] = l_i) \\
   (\I32.\CONST~i)~(\BRTABLE~l^\ast~l_N) &\stepto& (\BR~l_N)
     & (\iff |l^\ast| \leq i) \\
   \end{array}


.. _exec-return:

:math:`\RETURN`
...............

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`n` be the arity of :math:`F`.

3. Assert: due to :ref:`validation <valid-return>`, there are at least :math:`n` values on the top of the stack.

4. Pop the results :math:`\val^n` from the stack.

5. Assert: due to :ref:`validation <valid-return>`, the stack contains at least one :ref:`frame <syntax-frame>`.

6. While the top of the stack is not a frame, do:

   a. Pop the top element from the stack.

7. Assert: the top of the stack is the frame :math:`F`.

8. Pop the frame from the stack.

9. Push :math:`\val^n` to the stack.

10. Jump to the instruction after the original call that pushed the frame.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   \FRAME_n\{F\}~\XB^k[\val^n~\RETURN]~\END &\stepto& \val^n
   \end{array}


.. _exec-call:

:math:`\CALL~x`
...............

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call>`, :math:`F.\AMODULE.\MIFUNCS[x]` exists.

3. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`F.\AMODULE.\MIFUNCS[x]`.

4. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\CALL~x) &\stepto& F; (\INVOKE~a)
     & (\iff F.\AMODULE.\MIFUNCS[x] = a)
   \end{array}


.. _exec-call_indirect:

:math:`\CALLINDIRECT~x~y`
.........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\STABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITYPES[y]` exists.

7. Let :math:`\X{ft}_{\F{expect}}` be the :ref:`function type <syntax-functype>` :math:`F.\AMODULE.\MITYPES[y]`.

8. Assert: due to :ref:`validation <valid-call_indirect>`, a value with :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

11. Let :math:`r` be the :ref:`reference <syntax-ref>` :math:`\X{tab}.\TIELEM[i]`.

12. If :math:`r` is :math:`\REFNULL~t`, then:

    a. Trap.

13. Assert: due to :ref:`validation of table mutation <valid-table.set>`, :math:`r` is a :ref:`function reference <syntax-ref.func>`.

14. Let :math:`\REFFUNCADDR~a` be the :ref:`function reference <syntax-ref.func>` :math:`r`.

15. Assert: due to :ref:`validation of table mutation <valid-table.set>`, :math:`S.\SFUNCS[a]` exists.

16. Let :math:`\X{f}` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[a]`.

17. Let :math:`\X{ft}_{\F{actual}}` be the :ref:`function type <syntax-functype>` :math:`\X{f}.\FITYPE`.

18. If :math:`\X{ft}_{\F{actual}}` and :math:`\X{ft}_{\F{expect}}` differ, then:

    a. Trap.

19. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\CALLINDIRECT~x~y) &\stepto& S; F; (\INVOKE~a)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM[i] = \REFFUNCADDR~a \\
     \wedge & S.\SFUNCS[a] = f \\
     \wedge & F.\AMODULE.\MITYPES[y] = f.\FITYPE)
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\CALLINDIRECT~x~y) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise)
   \end{array}


.. index:: instruction, instruction sequence, block
.. _exec-instr-seq:

Blocks
~~~~~~

The following auxiliary rules define the semantics of executing an :ref:`instruction sequence <syntax-instr-seq>`
that forms a :ref:`block <exec-instr-control>`.


.. _exec-instr-seq-enter:

Entering :math:`\instr^\ast` with label :math:`L`
.................................................

1. Push :math:`L` to the stack.

2. Jump to the start of the instruction sequence :math:`\instr^\ast`.

.. note::
   No formal reduction rule is needed for entering an instruction sequence,
   because the label :math:`L` is embedded in the :ref:`administrative instruction <syntax-instr-admin>` that structured control instructions reduce to directly.


.. _exec-instr-seq-exit:

Exiting :math:`\instr^\ast` with label :math:`L`
................................................

When the end of a block is reached without a jump, exception, or trap aborting it, then the following steps are performed.

1. Let :math:`m` be the number of values on the top of the stack.

2. Pop the values :math:`\val^m` from the stack.

3. Assert: due to :ref:`validation <valid-instr-seq>`, the label :math:`L` is now on the top of the stack.

4. Pop the label from the stack.

5. Push :math:`\val^m` back to the stack.

6. Jump to the position after the |END| of the :ref:`structured control instruction <syntax-instr-control>` associated with the label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   \LABEL_n\{\instr^\ast\}~\val^m~\END &\stepto& \val^m
   \end{array}

.. note::
   This semantics also applies to the instruction sequence contained in a |LOOP| instruction.
   Therefore, execution of a loop falls off the end, unless a backwards branch is performed explicitly.


.. index:: exception handling, throw context
   pair: handling; exception

.. _exec-catch:

Exception Handling
~~~~~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of entering and exiting exception handlers through :ref:`try <syntax-try>` instructions and handling thrown exceptions.

.. _exec-handler-enter:

Entering an exception handler :math:`H`
.......................................

1. Push :math:`H` onto the stack.

.. note::
   No formal reduction rule is needed for installing an exception handler
   because it is an :ref:`administrative instruction <syntax-instr-admin>`
   that the :ref:`try <syntax-try>` instruction reduced to directly.

.. _exec-handler-exit:

Exiting an exception handler
............................

When the end of a :ref:`try <syntax-try>` instruction is reached without a jump, exception, or trap, then the following steps are performed.

1. Let :math:`m` be the number of values on the top of the stack.

2. Pop the values :math:`\val^m` from the stack.

3. Assert: due to :ref:`validation <valid-instr-seq>`, the handler :math:`H` is now on the top of the stack.

4. Pop the handler from the stack.

5. Push :math:`\val^m` back to the stack.

6. Jump to the position after the |END| of the originating |TRY| instruction associated with the handler :math:`H`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   \CATCHN_m\{instr^\ast\}~\val^m~\END &\stepto& \val^m
   \end{array}


.. _exec-throwaddr:

Throwing an exception with :ref:`exception address <syntax-exnaddr>` :math:`a`
..............................................................................

When a throw or a rethrow occurs, labels and call frames are popped if necessary,
until an exception handler is found on the top of the stack.

1. Assert: due to validation, :math:`S.\SEXNS[a]` exists.

2. Let :math:`[t^n] \to [t'^m]` be the :ref:`exception type <syntax-exntype>` :math:`S.\SEXNS[a].\EITYPE`.

3. Assert: due to :ref:`validation <valid-try>`, there are :math:`n` values on the top of the stack.

4. Pop the :math:`n` values :math:`\val^n` from the stack.

5. While the stack is not empty and the top of the stack is not an exception handler, do:

   a. Pop the top element from the stack.

6. Assert: The stack is now either empty or there is an exception handler on the top.


7. If there is an exception handler :math:`\CATCHN_m\{\instr^\ast\}` on the top of the stack, then:

   a. Pop the exception handler from the stack.

   b. Let :math:`L` be the label whose arity is :math:`m` and whose continuation is the end of the |TRY| instruction associated with the handler.

   c. Push the label :math:`L` on the stack.

   d. Enter the block :math:`\instr^\ast` with label :math:`L`.

   e. Push the :ref:`exception reference <syntax-refexnaddr>` :math:`(\REFEXNADDR~a~\val^n)` to the stack.
8. Else the stack is empty.

9. *TODO: return TBA administrative instruction for the unresolved throw.*


.. math::
   \begin{array}{rcl}
   S;~F;~\CATCHN_m\{\instr^\ast\}~\XT[\val^n~(\THROWADDR~a)]~\END &\stepto&
      S;~F;~\LABEL_m\{\}~(\REFEXNADDR~a~\val^n)~{\instr}^\ast~\END \\
   && \hspace{-12ex} (\iff S.\SEXNS[a]=\{\ETYPE~[t^n]\to[]\}) \\
   %   S;\val^n~(\THROWADDR~a) & \stepto & TBA \\
   \end{array}


.. index:: ! call, function, function instance, label, frame

Function Calls
~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of invoking a :ref:`function instance <syntax-funcinst>`
through one of the :ref:`call instructions <exec-instr-control>`
and returning from it.


.. _exec-invoke:

Invocation of :ref:`function address <syntax-funcaddr>` :math:`a`
.................................................................

1. Assert: due to :ref:`validation <valid-call>`, :math:`S.\SFUNCS[a]` exists.

2. Let :math:`f` be the :ref:`function instance <syntax-funcinst>`, :math:`S.\SFUNCS[a]`.

3. Let :math:`[t_1^n] \to [t_2^m]` be the :ref:`function type <syntax-functype>` :math:`f.\FITYPE`.

4. Let :math:`t^\ast` be the list of :ref:`value types <syntax-valtype>` :math:`f.\FICODE.\FLOCALS`.

5. Let :math:`\instr^\ast~\END` be the :ref:`expression <syntax-expr>` :math:`f.\FICODE.\FBODY`.

6. Assert: due to :ref:`validation <valid-call>`, :math:`n` values are on the top of the stack.

7. Pop the values :math:`\val^n` from the stack.

8. Let :math:`\val_0^\ast` be the list of zero values of types :math:`t^\ast`.

9. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~f.\FIMODULE, \ALOCALS~\val^n~(\default_t)^\ast \}`.

10. Push the activation of :math:`F` with arity :math:`m` to the stack.

11. Let :math:`L` be the :ref:`label <syntax-label>` whose arity is :math:`m` and whose continuation is the end of the function.

12. :ref:`Enter <exec-instr-seq-enter>` the instruction sequence :math:`\instr^\ast` with label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\INVOKE~a) &\stepto& S; \FRAME_m\{F\}~\LABEL_m\{\}~\instr^\ast~\END~\END
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\SFUNCS[a] = f \\
     \wedge & f.\FITYPE = [t_1^n] \to [t_2^m] \\
     \wedge & f.\FICODE = \{ \FTYPE~x, \FLOCALS~t^k, \FBODY~\instr^\ast~\END \} \\
     \wedge & F = \{ \AMODULE~f.\FIMODULE, ~\ALOCALS~\val^n~(\default_t)^k \})
     \end{array} \\
   \end{array}


.. _exec-invoke-exit:

Returning from a function
.........................

When the end of a function is reached without a jump (i.e., |RETURN|), exception, or trap aborting it, then the following steps are performed.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`n` be the arity of the activation of :math:`F`.

3. Assert: due to :ref:`validation <valid-instr-seq>`, there are :math:`n` values on the top of the stack.

4. Pop the results :math:`\val^n` from the stack.

5. Assert: due to :ref:`validation <valid-func>`, the frame :math:`F` is now on the top of the stack.

6. Pop the frame from the stack.

7. Push :math:`\val^n` back to the stack.

8. Jump to the instruction after the original call.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   \FRAME_n\{F\}~\val^n~\END &\stepto& \val^n
   \end{array}


.. index:: host function, store
.. _exec-invoke-host:

Host Functions
..............

Invoking a :ref:`host function <syntax-hostfunc>` has non-deterministic behavior.
It may either terminate with a :ref:`trap <trap>` or return regularly.
However, in the latter case, it must consume and produce the right number and types of WebAssembly :ref:`values <syntax-val>` on the stack,
according to its :ref:`function type <syntax-functype>`.

A host function may also modify the :ref:`store <syntax-store>`.
However, all store modifications must result in an :ref:`extension <extend-store>` of the original store, i.e., they must only modify mutable contents and must not have instances removed.
Furthermore, the resulting store must be :ref:`valid <valid-store>`, i.e., all data and code in it is well-typed.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\INVOKE~a) &\stepto& S'; \result
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\SFUNCS[a] = \{ \FITYPE~[t_1^n] \to [t_2^m], \FIHOSTCODE~\X{hf} \} \\
     \wedge & (S'; \result) \in \X{hf}(S; \val^n)) \\
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\INVOKE~a) &\stepto& S; \val^n~(\INVOKE~a)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\SFUNCS[a] = \{ \FITYPE~[t_1^n] \to [t_2^m], \FIHOSTCODE~\X{hf} \} \\
     \wedge & \bot \in \X{hf}(S; \val^n)) \\
     \end{array} \\
   \end{array}

Here, :math:`\X{hf}(S; \val^n)` denotes the implementation-defined execution of host function :math:`\X{hf}` in current store :math:`S` with arguments :math:`\val^n`.
It yields a set of possible outcomes, where each element is either a pair of a modified store :math:`S'` and a :ref:`result <syntax-result>`
or the special value :math:`\bot` indicating divergence.
A host function is non-deterministic if there is at least one argument for which the set of outcomes is not singular.

For a WebAssembly implementation to be :ref:`sound <soundness>` in the presence of host functions,
every :ref:`host function instance <syntax-funcinst>` must be :ref:`valid <valid-hostfuncinst>`,
which means that it adheres to suitable pre- and post-conditions:
under a :ref:`valid store <valid-store>` :math:`S`, and given arguments :math:`\val^n` matching the ascribed parameter types :math:`t_1^n`,
executing the host function must yield a non-empty set of possible outcomes each of which is either divergence or consists of a valid store :math:`S'` that is an :ref:`extension <extend-store>` of :math:`S` and a result matching the ascribed return types :math:`t_2^m`.
All these notions are made precise in the :ref:`Appendix <soundness>`.

.. note::
   A host function can call back into WebAssembly by :ref:`invoking <exec-invocation>` a function :ref:`exported <syntax-export>` from a :ref:`module <syntax-module>`.
   However, the effects of any such call are subsumed by the non-deterministic behavior allowed for the host function.



.. index:: expression
   pair: execution; expression
   single: abstract syntax; expression
.. _exec-expr:

Expressions
~~~~~~~~~~~

An :ref:`expression <syntax-expr>` is *evaluated* relative to a :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>` pointing to its containing :ref:`module instance <syntax-moduleinst>`.

1. Jump to the start of the instruction sequence :math:`\instr^\ast` of the expression.

2. Execute the instruction sequence.

3. Assert: due to :ref:`validation <valid-expr>`, the top of the stack contains a :ref:`value <syntax-val>`.

4. Pop the :ref:`value <syntax-val>` :math:`\val` from the stack.

The value :math:`\val` is the result of the evaluation.

.. math::
   S; F; \instr^\ast \stepto S'; F'; \instr'^\ast
   \qquad (\iff S; F; \instr^\ast~\END \stepto S'; F'; \instr'^\ast~\END)

.. note::
   Evaluation iterates this reduction rule until reaching a value.
   Expressions constituting :ref:`function <syntax-func>` bodies are executed during function :ref:`invocation <exec-invoke>`.
