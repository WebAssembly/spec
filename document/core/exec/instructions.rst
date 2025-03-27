.. index:: instruction, function type, store, validation
.. _exec-instr:

Instructions
------------

WebAssembly computation is performed by executing individual :ref:`instructions <syntax-instr>`.


.. index:: numeric instruction, determinism, non-determinism, trap, NaN, value, value type
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

Numeric instructions are defined in terms of the generic :ref:`numeric operators <exec-numeric>`.
The mapping of numeric instructions to their underlying operators is expressed by the following definition:

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{\IN}(i_1,\dots,i_k) &=& \xref{exec/numerics}{int-ops}{\F{i}\X{op}}_N(i_1,\dots,i_k) \\
   \X{op}_{\FN}(z_1,\dots,z_k) &=& \xref{exec/numerics}{float-ops}{\F{f}\X{op}}_N(z_1,\dots,z_k) \\
   \end{array}

And for :ref:`conversion operators <exec-cvtop>`:

.. math::
   \begin{array}{lll@{\qquad}l}
   \cvtop^{\sx^?}_{t_1,t_2}(c) &=& \xref{exec/numerics}{convert-ops}{\X{cvtop}}^{\sx^?}_{|t_1|,|t_2|}(c) \\
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

3. If :math:`\unopF_t(c_1)` is defined, then:

   a. Let :math:`c` be a possible result of computing :math:`\unopF_t(c_1)`.

   b. Push the value :math:`t.\CONST~c` to the stack.

4. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~t\K{.}\unop &\stepto& (t\K{.}\CONST~c)
     & (\iff c \in \unopF_t(c_1)) \\
   (t\K{.}\CONST~c_1)~t\K{.}\unop &\stepto& \TRAP
     & (\iff \unopF_{t}(c_1) = \{\})
   \end{array}


.. _exec-binop:

:math:`t\K{.}\binop`
....................

1. Assert: due to :ref:`validation <valid-binop>`, two values of :ref:`value type <syntax-valtype>` :math:`t` are on the top of the stack.

2. Pop the value :math:`t.\CONST~c_2` from the stack.

3. Pop the value :math:`t.\CONST~c_1` from the stack.

4. If :math:`\binopF_t(c_1, c_2)` is defined, then:

   a. Let :math:`c` be a possible result of computing :math:`\binopF_t(c_1, c_2)`.

   b. Push the value :math:`t.\CONST~c` to the stack.

5. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\binop &\stepto& (t\K{.}\CONST~c)
     & (\iff c \in \binopF_t(c_1,c_2)) \\
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\binop &\stepto& \TRAP
     & (\iff \binopF_{t}(c_1,c_2) = \{\})
   \end{array}


.. _exec-testop:

:math:`t\K{.}\testop`
.....................

1. Assert: due to :ref:`validation <valid-testop>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

2. Pop the value :math:`t.\CONST~c_1` from the stack.

3. Let :math:`c` be the result of computing :math:`\testopF_t(c_1)`.

4. Push the value :math:`\I32.\CONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~t\K{.}\testop &\stepto& (\I32\K{.}\CONST~c)
     & (\iff c = \testopF_t(c_1)) \\
   \end{array}


.. _exec-relop:

:math:`t\K{.}\relop`
....................

1. Assert: due to :ref:`validation <valid-relop>`, two values of :ref:`value type <syntax-valtype>` :math:`t` are on the top of the stack.

2. Pop the value :math:`t.\CONST~c_2` from the stack.

3. Pop the value :math:`t.\CONST~c_1` from the stack.

4. Let :math:`c` be the result of computing :math:`\relopF_t(c_1, c_2)`.

5. Push the value :math:`\I32.\CONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\relop &\stepto& (\I32\K{.}\CONST~c)
     & (\iff c = \relopF_t(c_1,c_2)) \\
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

:math:`\REFNULL~x`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-ref.null>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Push the value :math:`\REFNULL~\deftype` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\REFNULL~x) &\stepto& F; (\REFNULL~\deftype)
     & (\iff \deftype = F.\AMODULE.\MITYPES[x]) \\
   \end{array}

.. note::
   No formal reduction rule is required for the case |REFNULL| |ABSHEAPTYPE|,
   since the instruction form is already a :ref:`value <syntax-val>`.


.. _exec-ref.func:

:math:`\REFFUNC~x`
..................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-ref.func>`, :math:`F.\AMODULE.\MIFUNCS[x]` exists.

3. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`F.\AMODULE.\MIFUNCS[x]`.

4. Push the value :math:`\REFFUNCADDR~a` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\REFFUNC~x) &\stepto& F; (\REFFUNCADDR~a)
     & (\iff a = F.\AMODULE.\MIFUNCS[x]) \\
   \end{array}


.. _exec-ref.is_null:

:math:`\REFISNULL`
..................

1. Assert: due to :ref:`validation <valid-ref.is_null>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. Push the value :math:`\I32.\CONST~1` to the stack.

4. Else:

   a. Push the value :math:`\I32.\CONST~0` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \reff~\REFISNULL &\stepto& (\I32.\CONST~1)
     & (\iff \reff = \REFNULL~\X{ht}) \\
   \reff~\REFISNULL &\stepto& (\I32.\CONST~0)
     & (\otherwise) \\
   \end{array}


.. _exec-ref.as_non_null:

:math:`\REFASNONNULL`
.....................

1. Assert: due to :ref:`validation <valid-ref.is_null>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. Trap.

4. Push the value :math:`\reff` back to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \reff~\REFASNONNULL &\stepto& \TRAP
     & (\iff \reff = \REFNULL~\X{ht}) \\
   \reff~\REFASNONNULL &\stepto& \reff
     & (\otherwise) \\
   \end{array}


.. _exec-ref.eq:

:math:`\REFEQ`
..............

1. Assert: due to :ref:`validation <valid-ref.eq>`, two :ref:`reference values <syntax-ref>` are on the top of the stack.

2. Pop the value :math:`\reff_2` from the stack.

3. Pop the value :math:`\reff_1` from the stack.

4. If :math:`\reff_1` is the same as :math:`\reff_2`, then:

   a. Push the value :math:`\I32.\CONST~1` to the stack.

5. Else:

   a. Push the value :math:`\I32.\CONST~0` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \reff_1~\reff_2~\REFEQ &\stepto& (\I32.\CONST~1)
     & (\iff \reff_1 = (\REFNULL~\X{ht}_1) \land \reff_2 = (\REFNULL~\X{ht}_2)) \\
   \reff_1~\reff_2~\REFEQ &\stepto& (\I32.\CONST~1)
     & (\iff \reff_1 = \reff_2) \\
   \reff_1~\reff_2~\REFEQ &\stepto& (\I32.\CONST~0)
     & (\otherwise) \\
   \end{array}


.. _exec-ref.test:

:math:`\REFTEST~\X{rt}`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`\X{rt}_1` be the :ref:`reference type <syntax-reftype>` :math:`\insttype_{F.\AMODULE}(\X{rt})`.

3. Assert: due to :ref:`validation <valid-ref.test>`, :math:`\X{rt}_1` is :ref:`closed <type-closed>`.

4. Assert: due to :ref:`validation <valid-ref.test>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

5. Pop the value :math:`\reff` from the stack.

6. Assert: due to validation, the :ref:`reference value <syntax-ref>` is :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>`.

7. Let :math:`\X{rt}_2` be the :ref:`reference type <syntax-reftype>` of :math:`\reff`.

8. If the :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` :ref:`matches <match-reftype>` :math:`\X{rt}_1`, then:

   a. Push the value :math:`\I32.\CONST~1` to the stack.

9. Else:

   a. Push the value :math:`\I32.\CONST~0` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; F; \reff~(\REFTEST~\X{rt}) &\stepto& (\I32.\CONST~1)
     & (\iff S \vdashval \reff : \X{rt}'
        \land \vdashreftypematch \X{rt}' \matchesreftype \insttype_{F.\AMODULE}(\X{rt})) \\
   S; F; \reff~(\REFTEST~\X{rt}) &\stepto& (\I32.\CONST~0)
     & (\otherwise) \\
   \end{array}


.. _exec-ref.cast:

:math:`\REFCAST~\X{rt}`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`\X{rt}_1` be the :ref:`reference type <syntax-reftype>` :math:`\insttype_{F.\AMODULE}(\X{rt})`.

3. Assert: due to :ref:`validation <valid-ref.test>`, :math:`\X{rt}_1` is :ref:`closed <type-closed>`.

4. Assert: due to :ref:`validation <valid-ref.test>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

5. Pop the value :math:`\reff` from the stack.

6. Assert: due to validation, the :ref:`reference value <syntax-ref>` is :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>`.

7. Let :math:`\X{rt}_2` be the :ref:`reference type <syntax-reftype>` of :math:`\reff`.

8. If the :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` :ref:`matches <match-reftype>` :math:`\X{rt}_1`, then:

   a. Push the value :math:`\reff` back to the stack.

9. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; F; \reff~(\REFCAST~\X{rt}) &\stepto& \reff
     & (\iff S \vdashval \reff : \X{rt}'
        \land \vdashreftypematch \X{rt}' \matchesreftype \insttype_{F.\AMODULE}(\X{rt})) \\
   S; F; \reff~(\REFCAST~\X{rt}) &\stepto& \TRAP
     & (\otherwise) \\
   \end{array}



.. _exec-ref.i31:

:math:`\REFI31`
...............

1. Assert: due to :ref:`validation <valid-ref.i31>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~i` from the stack.

3. Let :math:`j` be the result of computing :math:`\wrap_{32,31}(i)`.

4. Push the reference value :math:`(\REFI31NUM~j)` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\I32.\CONST~i)~\REFI31 &\stepto& (\REFI31NUM~\wrap_{32,31}(i))
   \end{array}


.. _exec-i31.get_sx:

:math:`\I31GET\K{\_}\sx`
........................

1. Assert: due to :ref:`validation <valid-i31.get_sx>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~\I31)` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

4. Assert: due to :ref:`validation <valid-i31.get_sx>`, a :math:`\reff` is a :ref:`scalar reference <syntax-ref.i31>`.

5. Let :math:`\REFI31NUM~i` be the reference value :math:`\reff`.

6. Let :math:`j` be the result of computing :math:`\extend^{\sx}_{31,32}(i)`.

7. Push the value :math:`\I32.\CONST~j` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\REFI31NUM~i)~\I31GET\K{\_}\sx &\stepto& (\I32.\CONST~\extend^{\sx}_{31,32}(i)) \\
   (\REFNULL~t)~\I31GET\K{\_}\sx &\stepto& \TRAP
   \end{array}


.. _exec-struct.new:

:math:`\STRUCTNEW~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-struct.new>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-struct.new>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`structure type <syntax-structtype>`.

5. Let :math:`\TSTRUCT~\X{ft}^\ast` be the :ref:`expanded <aux-expand-deftype>` :ref:`structure type <syntax-structtype>` of :math:`\deftype`.

6. Let :math:`n` be the length of the :ref:`field type <syntax-fieldtype>` sequence :math:`\X{ft}^\ast`.

7. Assert: due to :ref:`validation <valid-struct.new>`, :math:`n` :ref:`values <syntax-val>` are on the top of the stack.

8. Pop the :math:`n` values :math:`\val^\ast` from the stack.

9. For every value :math:`\val_i` in :math:`\val^\ast` and corresponding :ref:`field type <syntax-fieldtype>` :math:`\X{ft}_i` in :math:`\X{ft}^\ast`:

   a. Let :math:`\fieldval_i` be the result of computing :math:`\packval_{\X{ft}_i}(\val_i))`.

10. Let :math:`\fieldval^\ast` the concatenation of all field values :math:`\fieldval_i`.

11. Let :math:`\X{si}` be the :ref:`structure instance <syntax-structinst>` :math:`\{\SITYPE~\deftype, \SIFIELDS~\fieldval^\ast\}`.

12. Let :math:`a` be the length of :math:`S.\SSTRUCTS`.

13. Append :math:`\X{si}` to :math:`S.\SSTRUCTS`.

14. Push the :ref:`structure reference <syntax-ref.struct>` :math:`\REFSTRUCTADDR~a` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; F; \val^n~(\STRUCTNEW~x) &\stepto& S'; F; (\REFSTRUCTADDR~|S.\SSTRUCTS|)
     \\&&
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TSTRUCT~\X{ft}^n \\
      \land & \X{si} = \{\SITYPE~F.\AMODULE.\MITYPES[x], \SIFIELDS~(\packval_{\X{ft}}(\val))^n\} \\
      \land & S' = S \with \SSTRUCTS = S.\SSTRUCTS~\X{si})
     \end{array} \\
   \end{array}


.. _exec-struct.new_default:

:math:`\STRUCTNEWDEFAULT~x`
...........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-struct.new_default>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-struct.new_default>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`structure type <syntax-structtype>`.

5. Let :math:`\TSTRUCT~\X{ft}^\ast` be the :ref:`expanded <aux-expand-deftype>` :ref:`structure type <syntax-structtype>` of :math:`\deftype`.

6. Let :math:`n` be the length of the :ref:`field type <syntax-fieldtype>` sequence :math:`\X{ft}^\ast`.

7. For every :ref:`field type <syntax-fieldtype>` :math:`\X{ft}_i` in :math:`\X{ft}^\ast`:

   a. Let :math:`t_i` be the :ref:`value type <syntax-valtype>` :math:`\unpacktype(\X{ft}_i)`.

   b. Assert: due to :ref:`validation <valid-struct.new_default>`, :math:`\default_{t_i}` is defined.

   c. Push the :ref:`value <syntax-val>` :math:`\default_{t_i}` to the stack.

8. Execute the instruction :math:`(\STRUCTNEW~x)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\STRUCTNEWDEFAULT~x) &\stepto& (\default_{\unpacktype(\X{ft})}))^n~(\STRUCTNEW~x)
     \\&&
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TSTRUCT~\X{ft}^n)
     \end{array} \\
   \end{array}

.. scratch
   .. math::
      \begin{array}{lcl@{\qquad}l}
      S; F; (\STRUCTNEWDEFAULT~x) &\stepto& S'; F; (\REFSTRUCTADDR~|S.\SSTRUCTS|)
        \\&&
        \begin{array}[t]{@{}r@{~}l@{}}
         (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TSTRUCT~\X{ft}^n \\
         \land & \X{si} = \{\SITYPE~F.\AMODULE.\MITYPES[x], \SIFIELDS~(\packval_{\X{ft}}(\default_{\unpacktype(\X{ft})}))^n\} \\
         \land & S' = S \with \SSTRUCTS = S.\SSTRUCTS~\X{si})
        \end{array} \\
      \end{array}


.. _exec-struct.get:
.. _exec-struct.get_sx:

:math:`\STRUCTGET\K{\_}\sx^?~x~y`
.................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-struct.get>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-struct.get>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`structure type <syntax-structtype>` with at least :math:`y + 1` fields.

5. Let :math:`\TSTRUCT~\X{ft}^\ast` be the :ref:`expanded <aux-expand-deftype>` :ref:`structure type <syntax-structtype>` of :math:`\deftype`.

6. Let :math:`\X{ft}_y` be the :math:`y`-th :ref:`field type <syntax-fieldtype>` of :math:`\X{ft}^\ast`.

7. Assert: due to :ref:`validation <valid-struct.get>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

8. Pop the value :math:`\reff` from the stack.

9. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

10. Assert: due to :ref:`validation <valid-struct.get>`, a :math:`\reff` is a :ref:`structure reference <syntax-ref.struct>`.

11. Let :math:`\REFSTRUCTADDR~a` be the reference value :math:`\reff`.

12. Assert: due to :ref:`validation <valid-struct.get>`, the :ref:`structure instance <syntax-structinst>` :math:`S.\SSTRUCTS[a]` exists and has at least :math:`y + 1` fields.

13. Let :math:`\fieldval` be the :ref:`field value <syntax-fieldval>` :math:`S.\SSTRUCTS[a].\SIFIELDS[y]`.

14. Let :math:`\val` be the result of computing :math:`\unpackval^{\sx^?}_{\X{ft}_y}(\fieldval))`.

15. Push the value :math:`\val` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; F; (\REFSTRUCTADDR~a)~(\STRUCTGET\K{\_}\sx^?~x~y) &\stepto& \val
     &
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TSTRUCT~\X{ft}^n \\
      \land & \val = \unpackval^{\sx^?}_{\X{ft}^n[y]}(S.\SSTRUCTS[a].\SIFIELDS[y]))
     \end{array} \\
   S; F; (\REFNULL~t)~(\STRUCTGET\K{\_}\sx^?~x~y) &\stepto& \TRAP
   \end{array}


.. _exec-struct.set:

:math:`\STRUCTSET~x~y`
......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-struct.set>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-struct.set>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`structure type <syntax-structtype>` with at least :math:`y + 1` fields.

5. Let :math:`\TSTRUCT~\X{ft}^\ast` be the :ref:`expanded <aux-expand-deftype>` :ref:`structure type <syntax-structtype>` of :math:`\deftype`.

6. Let :math:`\X{ft}_y` be the :math:`y`-th :ref:`field type <syntax-fieldtype>` of :math:`\X{ft}^\ast`.

7. Assert: due to :ref:`validation <valid-struct.set>`, a :ref:`value <syntax-val>` is on the top of the stack.

8. Pop the value :math:`\val` from the stack.

9. Assert: due to :ref:`validation <valid-struct.set>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

10. Pop the value :math:`\reff` from the stack.

11. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

12. Assert: due to :ref:`validation <valid-struct.set>`, a :math:`\reff` is a :ref:`structure reference <syntax-ref.struct>`.

13. Let :math:`\REFSTRUCTADDR~a` be the reference value :math:`\reff`.

14. Assert: due to :ref:`validation <valid-struct.set>`, the :ref:`structure instance <syntax-structinst>` :math:`S.\SSTRUCTS[a]` exists and has at least :math:`y + 1` fields.

15. Let :math:`\fieldval` be the result of computing :math:`\packval_{\X{ft}_y}(\val))`.

16. Replace the :ref:`field value <syntax-fieldval>` :math:`S.\SSTRUCTS[a].\SIFIELDS[y]` with :math:`\fieldval`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; F; (\REFSTRUCTADDR~a)~\val~(\STRUCTSET~x~y) &\stepto& S'; \epsilon
     &
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TSTRUCT~\X{ft}^n \\
      \land & S' = S \with \SSTRUCTS[a].\SIFIELDS[y] = \packval_{\X{ft}^n[y]}(\val))
     \end{array} \\
   S; F; (\REFNULL~t)~\val~(\STRUCTSET~x~y) &\stepto& \TRAP
   \end{array}


.. _exec-array.new:

:math:`\ARRAYNEW~x`
...................

1. Assert: due to :ref:`validation <valid-array.new>`, a :ref:`value <syntax-val>` of type :math:`\I32` is on the top of the stack.

2. Pop the value :math:`(\I32.\CONST~n)` from the stack.

3. Assert: due to :ref:`validation <valid-array.new>`, a :ref:`value <syntax-val>` is on the top of the stack.

4. Pop the value :math:`\val` from the stack.

5. Push the value :math:`\val` to the stack :math:`n` times.

6. Execute the instruction :math:`(\ARRAYNEWFIXED~x~n)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \val~(\I32.\CONST~n)~(\ARRAYNEW~x) &\stepto& \val^n~(\ARRAYNEWFIXED~x~n)
   \end{array}

.. scratch
   .. math::
      \begin{array}{lcl@{\qquad}l}
      S; F; \val~(\I32.\CONST~n)~(\ARRAYNEW~x) &\stepto& S'; F; (\REFARRAYADDR~|S.\SARRAYS|)
        \\&&
        \begin{array}[t]{@{}r@{~}l@{}}
         (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TARRAY~\X{ft} \\
         \land & \X{ai} = \{\AITYPE~F.\AMODULE.\MITYPES[x], \AIFIELDS~(\packval_{\X{ft}}(\val))^n\} \\
         \land & S' = S \with \SARRAYS = S.\SARRAYS~\X{ai})
        \end{array} \\
      \end{array}


.. _exec-array.new_default:

:math:`\ARRAYNEWDEFAULT~x`
..........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.new_default>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.new_default>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.new_default>`, a :ref:`value <syntax-val>` of type :math:`\I32` is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~n` from the stack.

8. Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpacktype(\X{ft})`.

9. Assert: due to :ref:`validation <valid-array.new_default>`, :math:`\default_t` is defined.

10. Push the :ref:`value <syntax-val>` :math:`\default_t` to the stack :math:`n` times.

11. Execute the instruction :math:`(\ARRAYNEWFIXED~x~n)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\I32.\CONST~n)~(\ARRAYNEWDEFAULT~x) &\stepto& (\default_{\unpacktype(\X{ft})})^n~(\ARRAYNEWFIXED~x~n)
     \\&&
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TARRAY~\X{ft})
     \end{array} \\
   \end{array}

.. scratch
   .. math::
      \begin{array}{lcl@{\qquad}l}
      S; F; (\I32.\CONST~n)~(\ARRAYNEWDEFAULT~x) &\stepto& S'; F; (\REFARRAYADDR~|S.\SARRAYS|)
        \\&&
        \begin{array}[t]{@{}r@{~}l@{}}
         (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TARRAY~\X{ft} \\
         \land & \X{ai} = \{\AITYPE~F.\AMODULE.\MITYPES[x], \AIFIELDS~(\packval_{\X{ft}}(\default_{\unpacktype(\X{ft}}))^n\} \\
         \land & S' = S \with \SARRAYS = S.\SARRAYS~\X{ai})
        \end{array} \\
      \end{array}


.. _exec-array.new_fixed:

:math:`\ARRAYNEWFIXED~x~n`
..........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.new_fixed>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.new_fixed>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.new_fixed>`, :math:`n` :ref:`values <syntax-val>` are on the top of the stack.

7. Pop the :math:`n` values :math:`\val^\ast` from the stack.

8. For every value :math:`\val_i` in :math:`\val^\ast`:

   a. Let :math:`\fieldval_i` be the result of computing :math:`\packval_{\X{ft}}(\val_i))`.

9. Let :math:`\fieldval^\ast` be the concatenation of all field values :math:`\fieldval_i`.

10. Let :math:`\X{ai}` be the :ref:`array instance <syntax-arrayinst>` :math:`\{\AITYPE~\deftype, \AIFIELDS~\fieldval^\ast\}`.

11. Let :math:`a` be the length of :math:`S.\SARRAYS`.

12. Append :math:`\X{ai}` to :math:`S.\SARRAYS`.

13. Push the :ref:`array reference <syntax-ref.array>` :math:`\REFARRAYADDR~a` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; F; \val^n~(\ARRAYNEWFIXED~x~n) &\stepto& S'; F; (\REFARRAYADDR~|S.\SARRAYS|)
     \\&&
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TARRAY~\X{ft} \\
      \land & \X{ai} = \{\AITYPE~F.\AMODULE.\MITYPES[x], \AIFIELDS~(\packval_{\X{ft}}(\val))^n\} \\
      \land & S' = S \with \SARRAYS = S.\SARRAYS~\X{ai})
     \end{array} \\
   \end{array}


.. _exec-array.new_data:

:math:`\ARRAYNEWDATA~x~y`
.........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]` exists.

7. Let :math:`\X{da}` be the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]`.

8. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]` exists.

9. Let :math:`\datainst` be the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]`.

10. Assert: due to :ref:`validation <valid-array.new_data>`, two :ref:`values <syntax-val>` of type :math:`\I32` are on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Pop the value :math:`\I32.\CONST~s` from the stack.

13. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`field type <syntax-fieldtype>` :math:`\X{ft}` has a defined :ref:`bit width <bitwidth-fieldtype>`.

14. Let :math:`z` be the :ref:`bit width <bitwidth-fieldtype>` of :ref:`field type <syntax-fieldtype>` :math:`\X{ft}` divided by eight.

15. If the sum of :math:`s` and :math:`n` times :math:`z` is larger than the length of :math:`\datainst.\DIDATA`, then:

    a. Trap.

16. Let :math:`b^\ast` be the :ref:`byte <syntax-byte>` sequence :math:`\datainst.\DIDATA[s \slice n \cdot z]`.

17. Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpacktype(\X{ft})`.

18. For each of the :math:`n` consecutive subsequences :math:`{b'}^z` of :math:`b^\ast`:

    a. Assert: due to :ref:`validation <valid-array.new_data>`, :math:`\bytes_{\X{ft}}` is defined.

    b. Let :math:`c_i` be the constant for which :math:`\bytes_{\X{ft}}(c_i)` is :math:`{b'}^z`.

    c. Push the value :math:`t.\CONST~c_i` to the stack.

19. Execute the instruction :math:`(\ARRAYNEWFIXED~x~n)`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYNEWDATA~x~y) &\stepto& \TRAP
     \\&&
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TARRAY~\X{ft} \\
      \land & s + n\cdot|\X{ft}|/8 > |S.\SDATAS[F.\AMODULE.\MIDATAS[y]].\DIDATA|)
     \end{array} \\
   \\[1ex]
   S; F; (\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYNEWDATA~x~y) &\stepto& (t.\CONST~c)^n~(\ARRAYNEWFIXED~x~n)
     \\&&
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TARRAY~\X{ft} \\
      \land & t = \unpacktype(\X{ft}) \\
      \land & \concat((\bytes_{\X{ft}}(c))^n) = S.\SDATAS[F.\AMODULE.\MIDATAS[y]].\DIDATA[s \slice n\cdot|\X{ft}|/8] \\
     \end{array} \\
   \end{array}


.. _exec-array.new_elem:

:math:`\ARRAYNEWELEM~x~y`
.........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.new_elem>`, the :ref:`element address <syntax-elemaddr>` :math:`F.\AMODULE.\MIELEMS[y]` exists.

3. Let :math:`\X{ea}` be the :ref:`element address <syntax-elemaddr>` :math:`F.\AMODULE.\MIELEMS[y]`.

4. Assert: due to :ref:`validation <valid-array.new_elem>`, the :ref:`element instance <syntax-eleminst>` :math:`S.\SELEMS[\X{ea}]` exists.

5. Let :math:`\eleminst` be the :ref:`element instance <syntax-eleminst>` :math:`S.\SELEMS[\X{ea}]`.

6. Assert: due to :ref:`validation <valid-array.new_elem>`, two :ref:`values <syntax-val>` of type :math:`\I32` are on the top of the stack.

7. Pop the value :math:`(\I32.\CONST~n)` from the stack.

8. Pop the value :math:`(\I32.\CONST~s)` from the stack.

9. If the sum of :math:`s` and :math:`n` is larger than the length of :math:`\eleminst.\EIELEM`, then:

   a. Trap.

10. Let :math:`\reff^\ast` be the :ref:`reference <syntax-ref>` sequence :math:`\eleminst.\EIELEM[s \slice n]`.

11. Push the references :math:`\reff^\ast` to the stack.

12. Execute the instruction :math:`(\ARRAYNEWFIXED~x~n)`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYNEWELEM~x~y) &\stepto& \TRAP
     \\&&
     (\iff s + n > |S.\SELEMS[F.\AMODULE.\MIELEMS[y]].\EIELEM|)
   \\[1ex]
   S; F; (\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYNEWELEM~x~y) &\stepto& \reff^n~(\ARRAYNEWFIXED~x~n)
     \\&&
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \reff^n = S.\SELEMS[F.\AMODULE.\MIELEMS[y]].\EIELEM[s \slice n])
     \end{array} \\
   \end{array}


.. _exec-array.get:
.. _exec-array.get_sx:

:math:`\ARRAYGET\K{\_}\sx^?~x`
..............................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.get>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.get>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.get>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Assert: due to :ref:`validation <valid-array.get>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

9. Pop the value :math:`\reff` from the stack.

10. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

11. Assert: due to :ref:`validation <valid-array.get>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

12. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

13. Assert: due to :ref:`validation <valid-array.get>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

14. If :math:`n` is larger than or equal to the length of :math:`S.\SARRAYS[a].\AIFIELDS`, then:

    a. Trap.

15. Let :math:`\fieldval` be the :ref:`field value <syntax-fieldval>` :math:`S.\SARRAYS[a].\AIFIELDS[i]`.

16. Let :math:`\val` be the result of computing :math:`\unpackval^{\sx^?}_{\X{ft}}(\fieldval))`.

17. Push the value :math:`\val` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~i)~(\ARRAYGET\K{\_}\sx^?~x) \stepto \TRAP
   \\ \qquad
    (\iff i \geq |\SARRAYS[a].\AIFIELDS|)
   \\[1ex]
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~i)~(\ARRAYGET\K{\_}\sx^?~x) \stepto \val
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TARRAY~\X{ft} \\
      \land & \val = \unpackval^{\sx^?}_{\X{ft}}(S.\SARRAYS[a].\AIFIELDS[i])) \\
     \end{array}
   \\[1ex]
   S; F; (\REFNULL~t)~(\I32.\CONST~i)~(\ARRAYGET\K{\_}\sx^?~x) \stepto \TRAP
   \end{array}


.. _exec-array.set:

:math:`\ARRAYSET~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.set>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.set>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.set>`, a :ref:`value <syntax-val>` is on the top of the stack.

7. Pop the value :math:`\val` from the stack.

8. Assert: due to :ref:`validation <valid-array.set>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. Assert: due to :ref:`validation <valid-array.set>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

11. Pop the value :math:`\reff` from the stack.

12. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

13. Assert: due to :ref:`validation <valid-array.set>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

14. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

15. Assert: due to :ref:`validation <valid-array.set>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

16. If :math:`n` is larger than or equal to the length of :math:`S.\SARRAYS[a].\AIFIELDS`, then:

    a. Trap.

17. Let :math:`\fieldval` be the result of computing :math:`\packval_{\X{ft}}(\val))`.

18. Replace the :ref:`field value <syntax-fieldval>` :math:`S.\SARRAYS[a].\AIFIELDS[i]` with :math:`\fieldval`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~i)~\val~(\ARRAYSET~x) \stepto \TRAP
   \\ \qquad
    (\iff i \geq |\SARRAYS[a].\AIFIELDS|)
   \\[1ex]
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~i)~\val~(\ARRAYSET~x) \stepto S'; \epsilon
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \expanddt(F.\AMODULE.\MITYPES[x]) = \TARRAY~\X{ft} \\
      \land & S' = S \with \SARRAYS[a].\AIFIELDS[i] = \packval_{\X{ft}}(\val)) \\
     \end{array}
   \\[1ex]
   S; F; (\REFNULL~t)~(\I32.\CONST~i)~\val~(\ARRAYSET~x) \stepto \TRAP
   \end{array}


.. _exec-array.len:

:math:`\ARRAYLEN`
.................

1. Assert: due to :ref:`validation <valid-array.len>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~\ARRAY)` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

4. Assert: due to :ref:`validation <valid-array.len>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

5. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

6. Assert: due to :ref:`validation <valid-array.len>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

7. Let :math:`n` be the length of :math:`S.\SARRAYS[a].\AIFIELDS`.

8. Push the :ref:`value <syntax-val>` :math:`(\I32.\CONST~n)` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; (\REFARRAYADDR~a)~\ARRAYLEN &\stepto& (\I32.\CONST~|S.\SARRAYS[a].\AIFIELDS|) \\
   S; (\REFNULL~t)~\ARRAYLEN &\stepto& \TRAP
   \end{array}


.. _exec-array.fill:

:math:`\ARRAYFILL~x`
....................

1. Assert: due to :ref:`validation <valid-array.fill>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

2. Pop the value :math:`n` from the stack.

3. Assert: due to :ref:`validation <valid-array.fill>`, a :ref:`value <syntax-val>` is on the top of the stack.

4. Pop the value :math:`\val` from the stack.

5. Assert: due to :ref:`validation <valid-array.fill>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

6. Pop the value :math:`d` from the stack.

7. Assert: due to :ref:`validation <valid-array.fill>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

8. Pop the value :math:`\reff` from the stack.

9. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

10. Assert: due to :ref:`validation <valid-array.fill>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

11. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

12. Assert: due to :ref:`validation <valid-array.fill>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

13. If :math:`d + n` is larger than the length of :math:`S.\SARRAYS[a].\AIFIELDS`, then:

    a. Trap.

14. If :math:`n = 0`, then:

    a. Return.

15. Push the value :math:`\REFARRAYADDR~a` to the stack.

16. Push the value :math:`\I32.\CONST~d` to the stack.

17. Push the value :math:`\val` to the stack.

18. Execute the instruction :math:`\ARRAYSET~x`.

19. Push the value :math:`\REFARRAYADDR~a` to the stack.

20. Assert: due to the earlier check against the array size, :math:`d+1 < 2^{32}`.

21. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

22. Push the value :math:`\val` to the stack.

23. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

24. Execute the instruction :math:`\ARRAYFILL~x`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; (\REFARRAYADDR~a)~(\I32.\CONST~d)~\val~(\I32.\CONST~n)~(\ARRAYFILL~x)
     \quad\stepto\quad \TRAP
     \\ \qquad
     (\iff d + n > |S.\SARRAYS[a].\AIFIELDS|)
   \\[1ex]
   S; (\REFARRAYADDR~a)~(\I32.\CONST~d)~\val~(\I32.\CONST~0)~(\ARRAYFILL~x)
     \quad\stepto\quad \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; (\REFARRAYADDR~a)~(\I32.\CONST~d)~\val~(\I32.\CONST~n+1)~(\ARRAYFILL~x)
     \quad\stepto
     \\ \quad
       \begin{array}[t]{@{}l@{}}
       (\REFARRAYADDR~a)~(\I32.\CONST~d)~\val~(\ARRAYSET~x) \\
       (\REFARRAYADDR~a)~(\I32.\CONST~d+1)~\val~(\I32.\CONST~n)~(\ARRAYFILL~x) \\
       \end{array}
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; (\REFNULL~t)~(\I32.\CONST~d)~\val~(\I32.\CONST~n)~(\ARRAYFILL~x) \quad\stepto\quad \TRAP
   \end{array}


.. _exec-array.copy:

:math:`\ARRAYCOPY~x~y`
......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.copy>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[y]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[y]`.

4. Assert: due to :ref:`validation <valid-array.copy>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\mut~\X{st}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~n` from the stack.

8. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~s` from the stack.

10. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~y)` is on the top of the stack.

11. Pop the value :math:`\reff_2` from the stack.

12. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

13. Pop the value :math:`\I32.\CONST~d` from the stack.

14. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

15. Pop the value :math:`\reff_1` from the stack.

16. If :math:`\reff_1` is :math:`\REFNULL~t`, then:

   a. Trap.

17. Assert: due to :ref:`validation <valid-array.copy>`, :math:`\reff_1` is an :ref:`array reference <syntax-ref.array>`.

18. Let :math:`\REFARRAYADDR~a_1` be the reference value :math:`\reff_1`.

19. If :math:`\reff_2` is :math:`\REFNULL~t`, then:

   a. Trap.

20. Assert: due to :ref:`validation <valid-array.copy>`, :math:`\reff_2` is an :ref:`array reference <syntax-ref.array>`.

21. Let :math:`\REFARRAYADDR~a_2` be the reference value :math:`\reff_2`.

22. Assert: due to :ref:`validation <valid-array.copy>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a_1]` exists.

23. Assert: due to :ref:`validation <valid-array.copy>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a_2]` exists.

24. If :math:`d + n` is larger than the length of :math:`S.\SARRAYS[a_1].\AIFIELDS`, then:

    a. Trap.

25. If :math:`s + n` is larger than the length of :math:`S.\SARRAYS[a_2].\AIFIELDS`, then:

    a. Trap.

26. If :math:`n = 0`, then:

    a. Return.

27. If :math:`d \leq s`, then:

    a. Push the value :math:`\REFARRAYADDR~a_1` to the stack.

    b. Push the value :math:`\I32.\CONST~d` to the stack.

    c. Push the value :math:`\REFARRAYADDR~a_2` to the stack.

    d. Push the value :math:`\I32.\CONST~s` to the stack.

    e. Execute :math:`\getfield(\X{st})`.

    f. Execute the instruction :math:`\ARRAYSET~x`.

    g. Push the value :math:`\REFARRAYADDR~a_1` to the stack.

    h. Assert: due to the earlier check against the array size, :math:`d+1 < 2^{32}`.

    i. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

    j. Push the value :math:`\REFARRAYADDR~a_2` to the stack.

    k. Assert: due to the earlier check against the array size, :math:`s+1 < 2^{32}`.

    l. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

28. Else:

    a. Push the value :math:`\REFARRAYADDR~a_1` to the stack.

    b. Assert: due to the earlier check against the array size, :math:`d+n-1 < 2^{32}`.

    c. Push the value :math:`\I32.\CONST~(d+n-1)` to the stack.

    d. Push the value :math:`\REFARRAYADDR~a_2` to the stack.

    e. Assert: due to the earlier check against the array size, :math:`s+n-1 < 2^{32}`.

    f. Push the value :math:`\I32.\CONST~(s+n-1)` to the stack.

    g. Execute :math:`\getfield(\X{st})`.

    h. Execute the instruction :math:`\ARRAYSET~x`.

    i. Push the value :math:`\REFARRAYADDR~a_1` to the stack.

    j. Push the value :math:`\I32.\CONST~d` to the stack.

    k. Push the value :math:`\REFARRAYADDR~a_2` to the stack.

    l. Push the value :math:`\I32.\CONST~s` to the stack.

29. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

30. Execute the instruction :math:`\ARRAYCOPY~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\REFARRAYADDR~a_1)~(\I32.\CONST~d)~(\REFARRAYADDR~a_2)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYCOPY~x~y)
     \quad\stepto\quad \TRAP
     \\ \qquad
     (\iff d + n > |S.\SARRAYS[a_1].\AIFIELDS| \vee s + n > |S.\SARRAYS[a_2].\AIFIELDS|)
   \\[1ex]
   S; F; (\REFARRAYADDR~a_1)~(\I32.\CONST~d)~(\REFARRAYADDR~a_2)~(\I32.\CONST~s)~(\I32.\CONST~0)~(\ARRAYCOPY~x~y)
     \quad\stepto\quad \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\REFARRAYADDR~a_1)~(\I32.\CONST~d)~(\REFARRAYADDR~a_2)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\ARRAYCOPY~x~y)
     \quad\stepto
     \\ \quad
       \begin{array}[t]{@{}l@{}}
       (\REFARRAYADDR~a_1)~(\I32.\CONST~d) \\
       (\REFARRAYADDR~a_2)~(\I32.\CONST~s)~\getfield(\X{st}) \\
       (\ARRAYSET~x) \\
       (\REFARRAYADDR~a_1)~(\I32.\CONST~d+1)~(\REFARRAYADDR~a_2)~(\I32.\CONST~s+1)~(\I32.\CONST~n)~(\ARRAYCOPY~x~y) \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d \leq s \land F.\AMODULE.\MITYPES[y] = \TARRAY~\mut~\X{st}) \\
   \\[1ex]
   S; F; (\REFARRAYADDR~a_1)~(\I32.\CONST~d)~(\REFARRAYADDR~a_2)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\ARRAYCOPY~x~y)
     \quad\stepto
     \\ \quad
       \begin{array}[t]{@{}l@{}}
       (\REFARRAYADDR~a_1)~(\I32.\CONST~d+n) \\
       (\REFARRAYADDR~a_2)~(\I32.\CONST~s+n)~\getfield(\X{st}) \\
       (\ARRAYSET~x) \\
       (\REFARRAYADDR~a_1)~(\I32.\CONST~d)~(\REFARRAYADDR~a_2)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYCOPY~x~y) \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d > s \land F.\AMODULE.\MITYPES[y] = \TARRAY~\mut~\X{st}) \\
   \\[1ex]
   S; F; (\REFNULL~t)~(\I32.\CONST~d)~\val~(\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYCOPY~x~y) \quad\stepto\quad \TRAP
   \\[1ex]
   S; F; \val~(\I32.\CONST~d)~(\REFNULL~t)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYCOPY~x~y) \quad\stepto\quad \TRAP
   \end{array}

Where:

.. _aux-getfield:

.. math::
   \begin{array}{lll}
   \getfield(\valtype) &=& \ARRAYGET~y \\
   \getfield(\packedtype) &=& \ARRAYGETU~y \\
   \end{array}


.. _exec-array.init_data:

:math:`\ARRAYINITDATA~x~y`
..........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]` exists.

7. Let :math:`\X{da}` be the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]`.

8. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]` exists.

9. Let :math:`\datainst` be the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]`.

10. Assert: due to :ref:`validation <valid-array.init_data>`, three values of type :math:`\I32` are on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Pop the value :math:`\I32.\CONST~s` from the stack.

13. Pop the value :math:`\I32.\CONST~d` from the stack.

14. Assert: due to :ref:`validation <valid-array.init_data>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

15. Pop the value :math:`\reff` from the stack.

16. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

17. Assert: due to :ref:`validation <valid-array.init_data>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

18. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

19. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

20. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`field type <syntax-fieldtype>` :math:`\X{ft}` has a defined :ref:`bit width <bitwidth-fieldtype>`.

21. Let :math:`z` be the :ref:`bit width <bitwidth-fieldtype>` of :ref:`field type <syntax-fieldtype>` :math:`\X{ft}` divided by eight.

22. If :math:`d + n` is larger than the length of :math:`S.\SARRAYS[a].\AIFIELDS`, or the sum of :math:`s` and :math:`n` times :math:`z` is larger than the length of :math:`\datainst.\DIDATA`, then:

    a. Trap.

23. If :math:`n = 0`, then:

    a. Return.

24. Let :math:`b^\ast` be the :ref:`byte <syntax-byte>` sequence :math:`\datainst.\DIDATA[s \slice z]`.

25. Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpacktype(\X{ft})`.

26. Assert: due to :ref:`validation <valid-array.init_data>`, :math:`\bytes_{\X{ft}}` is defined.

27. Let :math:`c` be the constant for which :math:`\bytes_{\X{ft}}(c)` is :math:`b^\ast`.

28. Push the value :math:`\REFARRAYADDR~a` to the stack.

29. Push the value :math:`\I32.\CONST~d` to the stack.

30. Push the value :math:`t.\CONST~c` to the stack.

31. Execute the instruction :math:`\ARRAYSET~x`.

32. Push the value :math:`\REFARRAYADDR~a` to the stack.

33. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

34. Push the value :math:`\I32.\CONST~(s+z)` to the stack.

35. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

36. Execute the instruction :math:`\ARRAYINITDATA~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYINITDATA~x~y) \quad\stepto\quad \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & d + n > |S.\SARRAYS[a].\AIFIELDS| \\
      \vee & (F.\AMODULE.\MITYPES[x] = \TARRAY~\X{ft} \land
              s + n\cdot|\X{ft}|/8 > |S.\SDATAS[F.\AMODULE.\MIDATAS[y]].\DIDATA|))
     \end{array}
   \\[1ex]
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~0)~(\ARRAYINITDATA~x~y)
     \quad\stepto\quad \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\ARRAYINITDATA~x~y)
     \quad\stepto
     \\ \quad
     \begin{array}[t]{@{}l@{}}
     (\REFARRAYADDR~a)~(\I32.\CONST~d)~(t.\CONST~c)~(\ARRAYSET~x) \\
     (\REFARRAYADDR~a)~(\I32.\CONST~d+1)~(\I32.\CONST~s+|\X{ft}|/8)~(\I32.\CONST~n)~(\ARRAYINITDATA~x~y) \\
     \end{array}
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\otherwise, \iff & F.\AMODULE.\MITYPES[x] = \TARRAY~\X{ft} \\
      \land & t = \unpacktype(\X{ft}) \\
      \land & \bytes_{\X{ft}}(c) = S.\SDATAS[F.\AMODULE.\MIDATAS[y]].\DIDATA[s \slice |\X{ft}|/8]
     \end{array}
   \\[1ex]
   S; F; (\REFNULL~t)~(\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYINITDATA~x~y) \quad\stepto\quad \TRAP
   \end{array}


.. _exec-array.init_elem:

:math:`\ARRAYINITELEM~x~y`
..........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.init_elem>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.init_elem>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.init_elem>`, the :ref:`element address <syntax-elemaddr>` :math:`F.\AMODULE.\MIELEMS[y]` exists.

7. Let :math:`\X{ea}` be the :ref:`element address <syntax-elemaddr>` :math:`F.\AMODULE.\MIELEMS[y]`.

8. Assert: due to :ref:`validation <valid-array.init_elem>`, the :ref:`element instance <syntax-eleminst>` :math:`S.\SELEMS[\X{ea}]` exists.

9. Let :math:`\eleminst` be the :ref:`element instance <syntax-eleminst>` :math:`S.\SELEMS[\X{ea}]`.

10. Assert: due to :ref:`validation <valid-array.init_elem>`, three values of type :math:`\I32` are on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Pop the value :math:`\I32.\CONST~s` from the stack.

13. Pop the value :math:`\I32.\CONST~d` from the stack.

14. Assert: due to :ref:`validation <valid-array.init_elem>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

15. Pop the value :math:`\reff` from the stack.

16. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

17. Assert: due to :ref:`validation <valid-array.init_elem>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

18. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

19. Assert: due to :ref:`validation <valid-array.init_elem>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

20. If :math:`d + n` is larger than the length of :math:`S.\SARRAYS[a].\AIFIELDS`, or :math:`s + n` is larger than the length of :math:`\eleminst.\EIELEM`, then:

    a. Trap.

21. If :math:`n = 0`, then:

    a. Return.

22. Let :math:`\reff'` be the :ref:`reference value <syntax-ref>` :math:`\eleminst.\EIELEM[s]`.

23. Push the value :math:`\REFARRAYADDR~a` to the stack.

24. Push the value :math:`\I32.\CONST~d` to the stack.

25. Push the value :math:`\reff'` to the stack.

26. Execute the instruction :math:`\ARRAYSET~x`.

27. Push the value :math:`\REFARRAYADDR~a` to the stack.

28. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

29. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

30. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

31. Execute the instruction :math:`\ARRAYINITELEM~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYINITELEM~x~y) \quad\stepto\quad \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & d + n > |S.\SARRAYS[a].\AIFIELDS| \\
      \vee & s + n > |S.\SELEMS[F.\AMODULE.\MIELEMS[y]].\EIELEM|)
     \end{array}
   \\[1ex]
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~0)~(\ARRAYINITELEM~x~y)
     \quad\stepto\quad \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\REFARRAYADDR~a)~(\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\ARRAYINITELEM~x~y)
     \quad\stepto
     \\ \quad
     \begin{array}[t]{@{}l@{}}
     (\REFARRAYADDR~a)~(\I32.\CONST~d)~\REF~(\ARRAYSET~x) \\
     (\REFARRAYADDR~a)~(\I32.\CONST~d+1)~(\I32.\CONST~s+1)~(\I32.\CONST~n)~(\ARRAYINITELEM~x~y) \\
     \end{array}
     \\ \qquad
     (\otherwise, \iff \REF = S.\SELEMS[F.\AMODULE.\MIELEMS[y]].\EIELEM[s])
   \\[1ex]
   S; F; (\REFNULL~t)~(\I32.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\ARRAYINITELEM~x~y) \quad\stepto\quad \TRAP
   \end{array}


.. _exec-any.convert_extern:

:math:`\ANYCONVERTEXTERN`
.........................

1. Assert: due to :ref:`validation <valid-any.convert_extern>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. Push the reference value :math:`(\REFNULL~\ANY)` to the stack.

4. Else:

   a. Assert: due to :ref:`validation <valid-any.convert_extern>`, a :math:`\reff` is an :ref:`external reference <syntax-ref.extern>`.

   b. Let :math:`\REFEXTERN~\reff'` be the reference value :math:`\reff`.

   c. Push the reference value :math:`\reff'` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\REFNULL~\X{ht})~\ANYCONVERTEXTERN &\stepto& (\REFNULL~\ANY) \\
   (\REFEXTERN~\reff)~\ANYCONVERTEXTERN &\stepto& \reff \\
   \end{array}


.. _exec-extern.convert_any:

:math:`\EXTERNCONVERTANY`
.........................

1. Assert: due to :ref:`validation <valid-extern.convert_any>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. Push the reference value :math:`(\REFNULL~\EXTERN)` to the stack.

4. Else:

   a. Let :math:`\reff'` be the reference value :math:`(\REFEXTERN~\reff)`.

   b. Push the reference value :math:`\reff'` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\REFNULL~\X{ht})~\EXTERNCONVERTANY &\stepto& (\REFNULL~\EXTERN) \\
   \reff~\EXTERNCONVERTANY &\stepto& (\REFEXTERN~\reff) & (\iff \reff \neq (\REFNULL~\X{ht})) \\
   \end{array}



.. index:: vector instruction
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-vec:

Vector Instructions
~~~~~~~~~~~~~~~~~~~

Vector instructions that operate bitwise are handled as integer operations of respective width.

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{\VN}(i_1,\dots,i_k) &=& \xref{exec/numerics}{int-ops}{\F{i}\X{op}}_N(i_1,\dots,i_k) \\
   \end{array}

Most other vector instructions are defined in terms of numeric operators that are applied lane-wise according to the given :ref:`shape <syntax-vec-shape>`.

.. math::
   \begin{array}{llll}
   \X{op}_{t\K{x}N}(n_1,\dots,n_k) &=&
     \lanes^{-1}_{t\K{x}N}(\xref{exec/instructions}{exec-instr-numeric}{\X{op}}_t(i_1,\dots,i_k)^\ast) & \qquad(\iff i_1^\ast = \lanes_{t\K{x}N}(n_1) \land \dots \land i_k^\ast = \lanes_{t\K{x}N}(n_k) \\
   \end{array}

.. note::
   For example, the result of instruction :math:`\K{i32x4}.\ADD` applied to operands :math:`v_1, v_2`
   invokes :math:`\ADD_{\K{i32x4}}(v_1, v_2)`, which maps to
   :math:`\lanes^{-1}_{\K{i32x4}}(\ADD_{\I32}(i_1, i_2)^\ast)`,
   where :math:`i_1^\ast` and :math:`i_2^\ast` are sequences resulting from invoking
   :math:`\lanes_{\K{i32x4}}(v_1)` and :math:`\lanes_{\K{i32x4}}(v_2)`
   respectively.

For non-deterministic operators this definition is generalized to sets:

.. math::
   \begin{array}{lll}
   \X{op}_{t\K{x}N}(n_1,\dots,n_k) &=&
     \{ \lanes^{-1}_{t\K{x}N}(i^\ast) ~|~ i^\ast \in \Large\times\xref{Step_pure/instructions}{exec-instr-numeric}{\X{op}}_t(i_1,\dots,i_k)^\ast \land i_1^\ast = \lanes_{t\K{x}N}(n_1) \land \dots \land i_k^\ast = \lanes_{t\K{x}N}(n_k) \} \\
   \end{array}

where :math:`\Large\times \{x^\ast\}^N` transforms a sequence of :math:`N` sets of values into a set of sequences of :math:`N` values by computing the set product:

.. math::
   \begin{array}{lll}
   \Large\times (S_1 \dots S_N) &=& \{ x_1 \dots x_N ~|~ x_1 \in S_1 \land \dots \land x_N \in S_N \}
   \end{array}


.. _exec-vconst:

:math:`\V128\K{.}\VCONST~c`
...........................

1. Push the value :math:`\V128.\VCONST~c` to the stack.

.. note::
   No formal reduction rule is required for this instruction, since |VCONST| instructions coincide with :ref:`values <syntax-val>`.


.. _exec-vvunop:

:math:`\V128\K{.}\vvunop`
.........................

1. Assert: due to :ref:`validation <valid-vvunop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`c` be the result of computing :math:`\vvunop_{\V128}(c_1)`.

4. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~\V128\K{.}\vvunop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c = \vvunop_{\V128}(c_1)) \\
   \end{array}


.. _exec-vvbinop:

:math:`\V128\K{.}\vvbinop`
..........................

1. Assert: due to :ref:`validation <valid-vvbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`c` be the result of computing :math:`\vvbinop_{\V128}(c_1, c_2)`.

5. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\V128\K{.}\vvbinop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c = \vvbinop_{\V128}(c_1, c_2)) \\
   \end{array}


.. _exec-vvternop:

:math:`\V128\K{.}\vvternop`
...........................

1. Assert: due to :ref:`validation <valid-vvternop>`, three values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_3` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`c` be the result of computing :math:`\vvternop_{\V128}(c_1, c_2, c_3)`.

6. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~(\V128\K{.}\VCONST~c_3)~\V128\K{.}\vvternop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c = \vvternop_{\V128}(c_1, c_2, c_3)) \\
   \end{array}


.. _exec-vvtestop:
.. _exec-vec-any_true:

:math:`\V128\K{.}\ANYTRUE`
..........................

1. Assert: due to :ref:`validation <valid-vvtestop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`i` be the result of computing :math:`\ine_{128}(c_1, 0)`.

4. Push the value :math:`\I32.\CONST~i` onto the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~\V128\K{.}\ANYTRUE &\stepto& (\I32\K{.}\CONST~i)
     & (\iff i = \ine_{128}(c_1, 0)) \\
   \end{array}


.. _exec-vec-swizzle:

:math:`\K{i8x16.}\SWIZZLE`
..........................

1. Assert: due to :ref:`validation <valid-vbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Let :math:`i^\ast` be the result of computing :math:`\lanes_{\I8X16}(c_2)`.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`j^\ast` be the result of computing :math:`\lanes_{\I8X16}(c_1)`.

6. Let :math:`c^\ast` be the concatenation of the two sequences :math:`j^\ast` and :math:`0^{240}`.

7. Let :math:`c'` be the result of computing :math:`\lanes^{-1}_{\I8X16}(c^\ast[ i^\ast[0] ] \dots c^\ast[ i^\ast[15] ])`.

8. Push the value :math:`\V128.\VCONST~c'` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\I8X16\K{.}\SWIZZLE &\stepto& (\V128\K{.}\VCONST~c')
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{\I8X16}(c_2) \\
      \wedge & c^\ast = \lanes_{\I8X16}(c_1)~0^{240} \\
      \wedge & c' = \lanes^{-1}_{\I8X16}(c^\ast[ i^\ast[0] ] \dots c^\ast[ i^\ast[15] ]))
     \end{array}
   \end{array}


.. _exec-relaxed_swizzle:

:math:`\K{i8x16.}\RELAXEDSWIZZLE`
.................................

.. todo: align the implementation of swizzle and relaxed_swizzle

1. Assert: due to :ref:`validation <valid-vbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`c'` be the result of computing :math:`\lanes^{-1}_{\I8X16}(\irelaxedswizzle(\lanes_{\I8X16}(c_1), \lanes_{\I8X16}(c_2)))`.

5. Push the value :math:`\V128.\VCONST~c'` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\I8X16\K{.}\irelaxedswizzle &\stepto& (\V128\K{.}\VCONST~c')
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & c' = \lanes^{-1}_{\I8X16}(\irelaxedswizzle(\lanes_{\I8X16}(c_1), \lanes_{\I8X16}(c_2)))
     \end{array}
   \end{array}


.. _exec-vec-shuffle:

:math:`\K{i8x16.}\SHUFFLE~x^\ast`
.................................

1. Assert: due to :ref:`validation <valid-vec-shuffle>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Assert: due to :ref:`validation <valid-vec-shuffle>`, for all :math:`x_i` in :math:`x^\ast` it holds that :math:`x_i < 32`.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Let :math:`i_2^\ast` be the result of computing :math:`\lanes_{\I8X16}(c_2)`.

5. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

6. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{\I8X16}(c_1)`.

7. Let :math:`i^\ast` be the concatenation of the two sequences :math:`i_1^\ast` and :math:`i_2^\ast`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\I8X16}(i^\ast[x^\ast[0]] \dots i^\ast[x^\ast[15]])`.

9. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~(\I8X16\K{.}\SHUFFLE~x^\ast) &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{\I8X16}(c_1)~\lanes_{\I8X16}(c_2) \\
      \wedge & c = \lanes^{-1}_{\I8X16}(i^\ast[x^\ast[0]] \dots i^\ast[x^\ast[15]]))
     \end{array}
   \end{array}


.. _exec-vec-splat:

:math:`\shape\K{.}\SPLAT`
.........................

1. Let :math:`t` be the type :math:`\unpackshape(\shape)`.

2. Assert: due to :ref:`validation <valid-vec-splat>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

3. Pop the value :math:`t.\CONST~c_1` from the stack.

4. Let :math:`N` be the integer :math:`\dim(\shape)`.

5. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\shape}(c_1^N)`.

6. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~\shape\K{.}\SPLAT &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff t = \unpackshape(\shape)
       \wedge c = \lanes^{-1}_{\shape}(c_1^{\dim(\shape)}))
     \\
   \end{array}


.. _exec-vec-extract_lane:

:math:`t_1\K{x}N\K{.}\EXTRACTLANE\K{\_}\sx^?~x`
...............................................

1. Assert: due to :ref:`validation <valid-vec-extract_lane>`, :math:`x < N`.

2. Assert: due to :ref:`validation <valid-vec-extract_lane>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}N}(c_1)`.

5. Let :math:`t_2` be the type :math:`\unpackshape(t_1\K{x}N)`.

6. Let :math:`c_2` be the result of computing :math:`\extend^{sx^?}_{t_1,t_2}(i^\ast[x])`.

7. Push the value :math:`t_2.\CONST~c_2` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(t_1\K{x}N\K{.}\EXTRACTLANE~x) &\stepto& (t_2\K{.}\CONST~c_2)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & t_2 = \unpackshape(t_1\K{x}N) \\
       \wedge & c_2 = \extend^{sx^?}_{t_1,t_2}(\lanes_{t_1\K{x}N}(c_1)[x]))
     \end{array}
   \end{array}


.. _exec-vec-replace_lane:

:math:`\shape\K{.}\REPLACELANE~x`
.................................

1. Assert: due to :ref:`validation <valid-vec-replace_lane>`, :math:`x < \dim(\shape)`.

2. Let :math:`t_2` be the type :math:`\unpackshape(\shape)`.

3. Assert: due to :ref:`validation <valid-vec-replace_lane>`, a value of :ref:`value type <syntax-valtype>` :math:`t_1` is on the top of the stack.

4. Pop the value :math:`t_2.\CONST~c_2` from the stack.

5. Assert: due to :ref:`validation <valid-vec-replace_lane>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

6. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

7. Let :math:`i^\ast` be the result of computing :math:`\lanes_{\shape}(c_1)`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\shape}(i^\ast \with [x] = c_2)`.

9. Push :math:`\V128.\VCONST~c` on the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(t_2\K{.}\CONST~c_2)~(\shape\K{.}\REPLACELANE~x) &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{\shape}(c_1) \\
       \wedge & c = \lanes^{-1}_{\shape}(i^\ast \with [x] = c_2))
     \end{array}
   \end{array}


.. _exec-vunop:

:math:`\shape\K{.}\vunop`
.........................

1. Assert: due to :ref:`validation <valid-vunop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`c` be the result of computing :math:`\vunop_{\shape}(c_1)`.

4. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~\shape\K{.}\vunop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c = \vunop_{\shape}(c_1))
   \end{array}


.. _exec-vbinop:

:math:`\shape\K{.}\vbinop`
..........................

1. Assert: due to :ref:`validation <valid-vbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. If :math:`\vbinop_{\shape}(c_1, c_2)` is defined:

   a. Let :math:`c` be a possible result of computing :math:`\vbinop_{\shape}(c_1, c_2)`.

   b. Push the value :math:`\V128.\VCONST~c` to the stack.

5. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\shape\K{.}\vbinop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c \in \vbinop_{\shape}(c_1, c_2)) \\
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\shape\K{.}\vbinop &\stepto& \TRAP
     & (\iff \vbinop_{\shape}(c_1, c_2) = \{\})
   \end{array}


.. _exec-vternop:

:math:`\shape\K{.}\vternop`
...........................

1. Assert: due to :ref:`validation <valid-vternop>`, three values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_3` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`c` be the result of computing :math:`\vternop_{\shape}(c_1, c_2, c_3)`.

6. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~(\V128\K{.}\VCONST~c_3)~\V128\K{.}\vternop &\stepto& (\V128\K{.}\VCONST~c) &
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff c = \vternop_{\shape}(c_1, c_2, c_3)) \\
     \end{array}
   \end{array}


.. _exec-relaxed_laneselect:

:math:`t\K{x}N\K{.}\RELAXEDLANESELECT`
......................................

1. Assert: due to :ref:`validation <valid-relaxed_laneselect>`, three values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_3` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`N` be the :ref:`bit width <syntax-valtype>` :math:`|t|` of :ref:`value type <syntax-valtype>` :math:`t`.

6. Let :math:`c` be the result of computing :math:`\irelaxedlaneselect_{t\K{x}N}(c_1, c_2, c_3)`.

7. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~(\V128\K{.}\VCONST~c_3)~\V128\K{.}\RELAXEDLANESELECT &\stepto& (\V128\K{.}\VCONST~c) & \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff c = \irelaxedlaneselect_{t\K{x}N}(c_1, c_2, c_3)^\ast \\
     \end{array}
   \end{array}


.. _exec-vrelop:

:math:`t\K{x}N\K{.}\vrelop`
...........................

1. Assert: due to :ref:`validation <valid-vrelop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{t\K{x}N}(c_1)`.

5. Let :math:`i_2^\ast` be the result of computing :math:`\lanes_{t\K{x}N}(c_2)`.

6. Let :math:`i^\ast` be the result of computing :math:`\vrelop_t(i_1^\ast, i_2^\ast)`.

7. Let :math:`j^\ast` be the result of computing :math:`\extends_{1,|t|}(i^\ast)`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t\K{x}N}(j^\ast)`.

9. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~t\K{x}N\K{.}\vrelop &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff c = \lanes^{-1}_{t\K{x}N}(\extends_{1,|t|}(\vrelop_t(\lanes_{t\K{x}N}(c_1), \lanes_{t\K{x}N}(c_2)))))
     \end{array}
   \end{array}


.. _exec-vishiftop:

:math:`t\K{x}N\K{.}\vishiftop`
..............................

1. Assert: due to :ref:`validation <valid-vishiftop>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~s` from the stack.

3. Assert: due to :ref:`validation <valid-vishiftop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t\K{x}N}(c_1)`.

6. Let :math:`j^\ast` be the result of computing :math:`\vishiftop_{t}(i^\ast, s^N)`.

7. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t\K{x}N}(j^\ast)`.

8. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\I32\K{.}\CONST~s)~t\K{x}N\K{.}\vishiftop &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i^\ast = \lanes_{t\K{x}N}(c_1) \\
     \wedge & c = \lanes^{-1}_{t\K{x}N}(\vishiftop_{t}(i^\ast, s^N)))
     \end{array}
   \end{array}


.. _exec-vtestop:
.. _exec-vec-all_true:

:math:`\shape\K{.}\ALLTRUE`
...........................

1. Assert: due to :ref:`validation <valid-vtestop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c` from the stack.

3. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{\shape}(c)`.

4. Let :math:`i` be the result of computing :math:`\tobool(\bigwedge(i_1 \neq 0)^\ast)`.

5. Push the value :math:`\I32.\CONST~i` onto the stack.


.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c)~\shape\K{.}\ALLTRUE &\stepto& (\I32\K{.}\CONST~i)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i_1^\ast = \lanes_{\shape}(c) \\
     \wedge & i = \tobool(\bigwedge(i_1 \neq 0)^\ast))
     \end{array}
   \end{array}


.. _exec-vec-bitmask:

:math:`t\K{x}N\K{.}\BITMASK`
............................

1. Assert: due to :ref:`validation <valid-vec-bitmask>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c` from the stack.

3. Let :math:`i_1^N` be the result of computing :math:`\lanes_{t\K{x}N}(c)`.

4. Let :math:`B` be the :ref:`bit width <syntax-valtype>` :math:`|t|` of :ref:`value type <syntax-valtype>` :math:`t`.

5. Let :math:`i_2^N` be the result of computing :math:`\ilts_{B}(i_1^N, 0^N)`.

6. Let :math:`j^\ast` be the concatenation of the two sequences :math:`i_2^N` and :math:`0^{32-N}`.

7. Let :math:`i` be the result of computing :math:`\ibits_{32}^{-1}(j^\ast)`.

8. Push the value :math:`\I32.\CONST~i` onto the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c)~t\K{x}N\K{.}\BITMASK &\stepto& (\I32\K{.}\CONST~i)
     & (\iff i = \ibits_{32}^{-1}(\ilts_{|t|}(\lanes_{t\K{x}N}(c), (0)^N) (0)^{32-N}))
     \\
   \end{array}


.. _exec-vec-narrow:

:math:`t_2\K{x}N\K{.}\NARROW\K{\_}t_1\K{x}M\K{\_}\sx`
.....................................................

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = 2\cdot M`.

2. Assert: due to :ref:`validation <valid-vec-narrow>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Let :math:`i_2^M` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_2)`.

5. Let :math:`d_2^M` be the result of computing :math:`\narrow^{\sx}_{|t_1|,|t_2|}(i_2^M)`.

6. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

7. Let :math:`i_1^M` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

8. Let :math:`d_1^M` be the result of computing :math:`\narrow^{\sx}_{|t_1|,|t_2|}(i_1^M)`.

9. Let :math:`j^N` be the concatenation of the two sequences :math:`d_1^M` and :math:`d_2^M`.

10. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(j^N)`.

11. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~t_2\K{x}N\K{.}\NARROW\_t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & d_1^M = \narrow^{\sx}_{|t_1|,|t_2|}( \lanes_{t_1\K{x}M}(c_1)) \\
     \wedge & d_2^M = \narrow^{\sx}_{|t_1|,|t_2|}( \lanes_{t_1\K{x}M}(c_2)) \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(d_1^M~d_2^M))
     \end{array}
   \end{array}


.. _exec-vcvtop:

:math:`t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx`
.....................................................

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = M`.

2. Assert: due to :ref:`validation <valid-vcvtop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

5. Let :math:`j^\ast` be the result of computing :math:`\vcvtop^{\sx}_{|t_1|,|t_2|}(i^\ast)`.

6. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(j^\ast)`.

7. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & c = \lanes^{-1}_{t_2\K{x}N}(\vcvtop^{\sx}_{|t_1|,|t_2|}(\lanes_{t_1\K{x}M}(c_1))))
     \end{array}
   \end{array}


:math:`t_2\K{x}N\K{.}\vcvtop\K{\_}\half\K{\_}t_1\K{x}M\K{\_}\sx^?`
..................................................................

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = M / 2`.

2. Assert: due to :ref:`validation <valid-vcvtop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

5. If :math:`\half` is :math:`\K{low}`, then:

   a. Let :math:`j^\ast` be the sequence :math:`i^\ast[0 \slice N]`.

6. Else:

   a. Let :math:`j^\ast` be the sequence :math:`i^\ast[N \slice N]`.

7. Let :math:`k^\ast` be the result of computing :math:`\vcvtop^{\sx^?}_{|t_1|,|t_2|}(j^\ast)`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(k^\ast)`.

9. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\vcvtop\K{\_}\half\K{\_}t_1\K{x}M\K{\_}\sx^? &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & c = \lanes^{-1}_{t_2\K{x}N}(\vcvtop^{\sx^?}_{|t_1|,|t_2|}(\lanes_{t_1\K{x}M}(c_1)[\half(0, N) \slice N])))
     \end{array}
   \end{array}

where:

.. math::
   \begin{array}{lcl}
   \K{low}(x, y) &=& x \\
   \K{high}(x, y) &=& y \\
   \end{array}


:math:`t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx^?\K{\_zero}`
.................................................................

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = 2 \cdot M`.

2. Assert: due to :ref:`validation <valid-vcvtop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

5. Let :math:`j^\ast` be the result of computing :math:`\vcvtop^{\sx^?}_{|t_1|,|t_2|}(i^\ast)`.

6. Let :math:`k^\ast` be the concatenation of the two sequences :math:`j^\ast` and :math:`0^M`.

7. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(k^\ast)`.

8. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx^?\K{\_zero} &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & c = \lanes^{-1}_{t_2\K{x}N}(\vcvtop^{\sx^?}_{|t_1|,|t_2|}(\lanes_{t_1\K{x}M}(c_1))~0^M))
     \end{array}
   \end{array}


.. _exec-vec-dot:

:math:`\K{i32x4.}\DOT\K{\_i16x8\_s}`
....................................

1. Assert: due to :ref:`validation <valid-vec-dot>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{\I16X8}(c_1)`.

5. Let :math:`j_1^\ast` be the result of computing :math:`\extends_{16,32}(i_1^\ast)`.

6. Let :math:`i_2^\ast` be the result of computing :math:`\lanes_{\I16X8}(c_2)`.

7. Let :math:`j_2^\ast` be the result of computing :math:`\extends_{16,32}(i_2^\ast)`.

8. Let :math:`(k_1~k_2)^\ast` be the result of computing :math:`\imul_{32}(j_1^\ast, j_2^\ast)`.

9. Let :math:`k^\ast` be the result of computing :math:`\iadd_{32}(k_1, k_2)^\ast`.

10. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\I32X4}(k^\ast)`.

11. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\K{i32x4.}\DOT\K{\_i16x8\_s} &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & (i_1~i_2)^\ast = \imul_{32}(\extends_{16,32}(\lanes_{\I16X8}(c_1)), \extends_{16,32}(\lanes_{\I16X8}(c_2))) \\
     \wedge & j^\ast = \iadd_{32}(i_1, i_2)^\ast \\
     \wedge & c = \lanes^{-1}_{\I32X4}(j^\ast))
     \end{array}
   \end{array}


.. _exec-relaxed_dot:


:math:`\K{i16x8.}\RELAXEDDOT\K{\_i8x16\_i7x16\_s}`
..................................................

.. todo: move more of this to numerics

1. Assert: due to :ref:`validation <valid-relaxed_dot>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`(i_1~i_2)^8` be the result of computing :math:`\irelaxeddotmul_{8,16}(\lanes_{\I8X16}(c_1), \lanes_{\I8X16}(c_2))`

5. Let :math:`j^8` be the result of computing :math:`\iaddsats_{16}(i_1, i_2)^8`.

6. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\I16X8}(j^8)`.

7. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{llcl@{\qquad}l}
   & (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\K{i16x8.}\RELAXEDDOT\K{\_i8x16\_i7x16\_s} &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & (i_1~i_2)^8 = \irelaxeddotmul_{8,16}(\lanes_{\I8X16}(c_1), \lanes_{\I8X16}(c_2)) \\
     \wedge & j^8 = \iaddsats_{16}(i_1, i_2)^8 \\
     \wedge & c = \lanes^{-1}_{\I16X8}(j^8))
     \end{array}
   \end{array}


:math:`\K{i32x4.}\RELAXEDDOT\K{\_i8x16\_i7x16\_add\_s}`
.......................................................

.. todo: move more of this to numerics

1. Assert: due to :ref:`validation <valid-relaxed_dot>`, three values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_3` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`(i_1~i_2)^8` be the result of computing :math:`\irelaxeddotmul_{8,16}(\lanes_{\I8X16}(c_1), \lanes_{\I8X16}(c_2))`

6. Let :math:`(j_1~j_2)^4` be the result of computing :math:`\iaddsats_{16}(i_1, i_2)^8`.

7. Let :math:`j^4` be the result of computing :math:`\iadd_{32}(\extends_{16,32}(j_1), \extends_{16,32}(j_2))^4`.

8. Let :math:`k^4` be the result of computing :math:`\lanes_{\I32X4}(c_3)`.

9. Let :math:`l^4` be the result of computing :math:`\iadd_{32}(j, k)^4`.

10. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\I32X4}(l^4)`.

11. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{llcl@{\qquad}l}
   & (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~(\V128\K{.}\VCONST~c_3)~\K{i32x4.}\RELAXEDDOT\K{\_i8x16\_i7x16\_add\_s} &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & (i_1~i_2)^8 = \irelaxeddotmul_{8,16}(\lanes_{\I8X16}(c_1), \lanes_{\I8X16}(c_2)) \\
     \wedge & (j_1~j_2)^4 = \iaddsats_{16}(i_1, i_2)^8 \\
     \wedge & j^4 = \iadd_{32}(\extends_{16,32}(j_1), \extends_{16,32}(j_2))^4 \\
     \wedge & k^4 = \lanes_{\I32X4}(c_3) \\
     \wedge & l^4 = \iadd_{32}(j, k)^4 \\
     \wedge & c = \lanes^{-1}_{\I32X4}(l^4))
     \end{array}
   \end{array}


.. _exec-vec-extmul:

:math:`t_2\K{x}N\K{.}\EXTMUL\K{\_}\half\K{\_}t_1\K{x}M\K{\_}\sx`
................................................................

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = M / 2`.

2. Assert: due to :ref:`validation <valid-vec-extmul>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

6. Let :math:`i_2^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_2)`.

7. If :math:`\half` is :math:`\K{low}`, then:

   a. Let :math:`j_1^\ast` be the sequence :math:`i_1^\ast[0 \slice N]`.

   b. Let :math:`j_2^\ast` be the sequence :math:`i_2^\ast[0 \slice N]`.

8. Else:

   a. Let :math:`j_1^\ast` be the sequence :math:`i_1^\ast[N \slice N]`.

   b. Let :math:`j_2^\ast` be the sequence :math:`i_2^\ast[N \slice N]`.

9. Let :math:`k_1^\ast` be the result of computing :math:`\extend^{\sx}_{|t_1|,|t_2|}(j_1^\ast)`.

10. Let :math:`k_2^\ast` be the result of computing :math:`\extend^{\sx}_{|t_1|,|t_2|}(j_2^\ast)`.

11. Let :math:`k^\ast` be the result of computing :math:`\imul_{|t_2|}(k_1^\ast, k_2^\ast)`.

12. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(k^\ast)`.

13. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~t_2\K{x}N\K{.}\EXTMUL\K{\_}\half\K{\_}t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i^\ast = \lanes_{t_1\K{x}M}(c_1)[\half(0, N) \slice N] \\
     \wedge & j^\ast = \lanes_{t_1\K{x}M}(c_2)[\half(0, N) \slice N] \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(\imul_{|t_2|}(\extend^{\sx}_{|t_1|,|t_2|}(i^\ast), \extend^{\sx}_{|t_1|,|t_2|}(j^\ast))))
     \end{array}

where:

.. math::
   \begin{array}{lcl}
   \K{low}(x, y) &=& x \\
   \K{high}(x, y) &=& y \\
   \end{array}


.. _exec-vec-extadd_pairwise:

:math:`t_2\K{x}N\K{.}\EXTADDPAIRWISE\_t_1\K{x}M\_\sx`
.....................................................

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = M / 2`.

2. Assert: due to :ref:`validation <valid-vec-extadd_pairwise>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

5. Let :math:`(j_1~j_2)^\ast` be the result of computing :math:`\extend^{\sx}_{|t_1|,|t_2|}(i^\ast)`.

6. Let :math:`k^\ast` be the result of computing :math:`\iadd_{|t_2|}(j_1, j_2)^\ast`.

7. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(k^\ast)`.

8. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\EXTADDPAIRWISE\_t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & (i_1~i_2)^\ast = \extend^{\sx}_{|t_1|,|t_2|}(\lanes_{t_1\K{x}M}(c_1)) \\
     \wedge & j^\ast = \iadd_{|t_2|}(i_1, i_2)^\ast \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(j^\ast))
     \end{array}
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
   \val_1~\val_2~(\I32\K{.}\CONST~c)~(\SELECT~t^?) &\stepto& \val_1
     & (\iff c \neq 0) \\
   \val_1~\val_2~(\I32\K{.}\CONST~c)~(\SELECT~t^?) &\stepto& \val_2
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

2. Assert: due to :ref:`validation <valid-local.get>`, :math:`F.\ALOCALS[x]` exists and is non-empty.

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

5. :ref:`Execute <exec-local.set>` the instruction :math:`\LOCALSET~x`.

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

6. Assert: due to :ref:`validation <valid-table.get>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

7. Pop the value :math:`\X{at}.\CONST~i` from the stack.

8. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIELEM`, then:

   a. Trap.

9. Let :math:`\val` be the value :math:`\X{tab}.\TIELEM[i]`.

10. Push the value :math:`\val` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\TABLEGET~x) &\stepto& S; F; \val
   \end{array}
   \\ \qquad
     (\iff S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM[i] = \val) \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\TABLEGET~x) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-table.set:

:math:`\TABLESET~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.set>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`a` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.set>`, :math:`S.\STABLES[a]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[a]`.

6. Assert: due to :ref:`validation <valid-table.set>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

7. Pop the value :math:`\val` from the stack.

8. Assert: due to :ref:`validation <valid-table.set>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

9. Pop the value :math:`\X{at}.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

11. Replace the element :math:`\X{tab}.\TIELEM[i]` with :math:`\val`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~\val~(\TABLESET~x) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     (\iff S' = S \with \STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM[i] = \val) \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~\val~(\TABLESET~x) &\stepto& S; F; \TRAP
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

6. Let :math:`\X{at}~\limits` be the :ref:`table type <syntax-tabletype>` :math:`\X{tab}.\TITYPE`.

7. Let :math:`\X{sz}` be the length of :math:`\X{tab}.\TIELEM`.

8. Push the value :math:`\X{at}.\CONST~\X{sz}` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\TABLESIZE~x) &\stepto& S; F; (\X{at}.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff |S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM| = \X{sz} \\
     \wedge S.\STABLES[F.\AMODULE.\MITABLES[x]].\TITYPE = \X{at}~\X{lim}~t)
     \end{array} \\
   \end{array}


.. index:: determinism, non-determinism
.. _exec-table.grow:

:math:`\TABLEGROW~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-table.grow>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`a` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-table.grow>`, :math:`S.\STABLES[a]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[a]`.

6. Let :math:`\X{sz}` be the length of :math:`S.\STABLES[a]`.

7. Assert: due to :ref:`validation <valid-table.grow>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

8. Pop the value :math:`t.\CONST~n` from the stack.

9. Assert: due to :ref:`validation <valid-table.fill>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

10. Pop the value :math:`\val` from the stack.

11. Let :math:`\X{err}` be the value :math:`2^{|\X{at}|}-1`, for which :math:`\signed_{|\X{at}|}(\X{err})` is :math:`-1`.

12. Either:

   a. If :ref:`growing <grow-table>` :math:`\X{tab}` by :math:`n` entries with initialization value :math:`\val` succeeds, then:

      i. Push the value :math:`\X{at}.\CONST~\X{sz}` to the stack.

   b. Else:

      i. Push the value :math:`\X{at}.\CONST~\X{err}` to the stack.

13. Or:

   a. push the value :math:`\X{at}.\CONST~\X{err}` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; \val~(\X{at}.\CONST~n)~(\TABLEGROW~x) &\stepto& S'; F; (\X{at}.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & F.\AMODULE.\MITABLES[x] = a \\
     \wedge & \X{sz} = |S.\STABLES[a].\TIELEM| \\
     \wedge & S' = S \with \STABLES[a] = \growtable(S.\STABLES[a], n, \val)) \\[1ex]
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; \val~(\X{at}.\CONST~n)~(\TABLEGROW~x) &\stepto& S; F; (\X{at}.\CONST~\signed_{|\X{at}|}^{-1}(-1))
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

6. Assert: due to :ref:`validation <valid-table.fill>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

7. Pop the value :math:`\X{at}.\CONST~n` from the stack.

8. Assert: due to :ref:`validation <valid-table.fill>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

9. Pop the value :math:`\val` from the stack.

10. Assert: due to :ref:`validation <valid-table.fill>`, a value of :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

11. Pop the value :math:`\X{at}.\CONST~i` from the stack.

12. If :math:`i + n` is larger than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

13. If :math:`n` is :math:`0`, then:

    a. Return.

14. Push the value :math:`\X{at}.\CONST~i` to the stack.

15. Push the value :math:`\val` to the stack.

16. Execute the instruction :math:`\TABLESET~x`.

17. Push the value :math:`\X{at}.\CONST~(i+1)` to the stack.

18. Push the value :math:`\val` to the stack.

19. Push the value :math:`\X{at}.\CONST~(n-1)` to the stack.

20. Execute the instruction :math:`\TABLEFILL~x`.

.. math::
   \begin{array}{l}
   S; F; (\X{at}.\CONST~i)~\val~(\X{at}.\CONST~n)~(\TABLEFILL~x)
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i + n > |S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\X{at}.\CONST~i)~\val~(\X{at}.\CONST~0)~(\TABLEFILL~x)
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\X{at}.\CONST~i)~\val~(\X{at}.\CONST~n+1)~(\TABLEFILL~x)
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\X{at}.\CONST~i)~\val~(\TABLESET~x) \\
       (\X{at}.\CONST~i+1)~\val~(\X{at}.\CONST~n)~(\TABLEFILL~x) \\
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

10. Assert: due to :ref:`validation <valid-table.copy>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}_n` is on the top of the stack.

11. Pop the value :math:`\X{at}_n.\CONST~n` from the stack.

12. Assert: due to :ref:`validation <valid-table.copy>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}_s` is on the top of the stack.

13. Pop the value :math:`\X{at}_s.\CONST~s` from the stack.

14. Assert: due to :ref:`validation <valid-table.copy>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}_d` is on the top of the stack.

15. Pop the value :math:`\X{at}_d.\CONST~d` from the stack.

16. If :math:`s + n` is larger than the length of :math:`\X{tab}_y.\TIELEM` or :math:`d + n` is larger than the length of :math:`\X{tab}_x.\TIELEM`, then:

    a. Trap.

20. If :math:`n = 0`, then:

   a. Return.

21. If :math:`d \leq s`, then:

   a. Push the value :math:`\X{at}_d.\CONST~d` to the stack.

   b. Push the value :math:`\X{at}_s.\CONST~s` to the stack.

   c. Execute the instruction :math:`\TABLEGET~y`.

   d. Execute the instruction :math:`\TABLESET~x`.

   e. Assert: due to the earlier check against the table size, :math:`d+1 < 2^{32}`.

   f. Push the value :math:`\X{at}_d.\CONST~(d+1)` to the stack.

   g. Assert: due to the earlier check against the table size, :math:`s+1 < 2^{32}`.

   h. Push the value :math:`\X{at}_s.\CONST~(s+1)` to the stack.

22. Else:

   a. Assert: due to the earlier check against the table size, :math:`d+n-1 < 2^{32}`.

   b. Push the value :math:`\X{at}_d.\CONST~(d+n-1)` to the stack.

   c. Assert: due to the earlier check against the table size, :math:`s+n-1 < 2^{32}`.

   d. Push the value :math:`\X{at}_s.\CONST~(s+n-1)` to the stack.

   c. Execute the instruction :math:`\TABLEGET~y`.

   f. Execute the instruction :math:`\TABLESET~x`.

   g. Push the value :math:`\X{at}_d.\CONST~d` to the stack.

   h. Push the value :math:`\X{at}_s.\CONST~s` to the stack.

23. Push the value :math:`\X{at}_n.\CONST~(n-1)` to the stack.

24. Execute the instruction :math:`\TABLECOPY~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\X{at}_d.\CONST~d)~(\X{at}_s.\CONST~s)~(\X{at}_n.\CONST~n)~(\TABLECOPY~x~y)
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & s + n > |S.\STABLES[F.\AMODULE.\MITABLES[y]].\TIELEM| \\
      \vee & d + n > |S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\X{at}_d.\CONST~d)~(\X{at}_s.\CONST~s)~(\X{at}_n.\CONST~0)~(\TABLECOPY~x~y)
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\X{at}_d.\CONST~d)~(\X{at}_s.\CONST~s)~(\X{at}_n.\CONST~n+1)~(\TABLECOPY~x~y)
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\X{at}_d.\CONST~d)~(\X{at}_s.\CONST~s)~(\TABLEGET~y)~(\TABLESET~x) \\
       (\X{at}_d.\CONST~d+1)~(\X{at}_s.\CONST~s+1)~(\X{at}_n.\CONST~n)~(\TABLECOPY~x~y) \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d \leq s)
   \\[1ex]
   S; F; (\X{at}_d.\CONST~d)~(\X{at}_s.\CONST~s)~(\X{at}_n.\CONST~n+1)~(\TABLECOPY~x~y)
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\X{at}_d.\CONST~d+n)~(\X{at}_s.\CONST~s+n)~(\TABLEGET~y)~(\TABLESET~x) \\
       (\X{at}_d.\CONST~d)~(\X{at}_s.\CONST~s)~(\X{at}_n.\CONST~n)~(\TABLECOPY~x~y) \\
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

10. Assert: due to :ref:`validation <valid-table.init>`, a value of :ref:`value type <syntax-valtype>` :math:`\I32` is on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Assert: due to :ref:`validation <valid-table.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

13. Pop the value :math:`\I32.\CONST~s` from the stack.

14. Assert: due to :ref:`validation <valid-table.init>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

15. Pop the value :math:`\X{at}.\CONST~d` from the stack.

16. If :math:`s + n` is larger than the length of :math:`\X{elem}.\EIELEM` or :math:`d + n` is larger than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

17. If :math:`n = 0`, then:

    a. Return.

18. Let :math:`\val` be the :ref:`reference value <syntax-ref>` :math:`\X{elem}.\EIELEM[s]`.

19. Push the value :math:`\X{at}.\CONST~d` to the stack.

20. Push the value :math:`\val` to the stack.

21. Execute the instruction :math:`\TABLESET~x`.

22. Assert: due to the earlier check against the table size, :math:`d+1 < 2^{32}`.

23. Push the value :math:`\X{at}.\CONST~(d+1)` to the stack.

24. Assert: due to the earlier check against the segment size, :math:`s+1 < 2^{32}`.

25. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

26. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

27. Execute the instruction :math:`\TABLEINIT~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\X{at}.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\TABLEINIT~x~y)
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & s + n > |S.\SELEMS[F.\AMODULE.\MIELEMS[y]].\EIELEM| \\
      \vee & d + n > |S.\STABLES[F.\AMODULE.\MITABLES[x]].\TIELEM|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\X{at}.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~0)~(\TABLEINIT~x~y)
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\X{at}.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\TABLEINIT~x~y)
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\X{at}.\CONST~d)~\val~(\TABLESET~x) \\
       (\X{at}.\CONST~d+1)~(\I32.\CONST~s+1)~(\I32.\CONST~n)~(\TABLEINIT~x~y) \\
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

5. Replace :math:`S.\SELEMS[a].\EIELEM` with :math:`\epsilon`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\ELEMDROP~x) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     (\iff S' = S \with \SELEMS[F.\AMODULE.\MIELEMS[x]].\EIELEM = \epsilon) \\
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

:math:`t\K{.}\LOAD~x~\memarg` and :math:`t\K{.}\LOAD{N}\K{\_}\sx~x~\memarg`
...........................................................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-loadn>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-loadn>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-loadn>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

7. Pop the value :math:`\X{at}.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`N` is not part of the instruction, then:

   a. Let :math:`N` be the :ref:`bit width <syntax-numtype>` :math:`|t|` of :ref:`number type <syntax-numtype>` :math:`t`.

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
   S; F; (\X{at}.\CONST~i)~(t.\LOAD~x~\memarg) &\stepto& S; F; (t.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + |t|/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & \bytes_t(c) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} \slice |t|/8]) \\[1ex]
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(t.\LOAD{N}\K{\_}\sx~x~\memarg) &\stepto&
     S; F; (t.\CONST~\extend^{\sx}_{N,|t|}(n))
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & \bytes_{\iN}(n) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} \slice N/8]) \\[1ex]
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(t.\LOAD({N}\K{\_}\sx)^?~x~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-load-extend:

:math:`\V128\K{.}\LOAD{M}\K{x}N\_\sx~x~\memarg`
...............................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-load-extend>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-load-extend>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-load-extend>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

7. Pop the value :math:`\X{at}.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`\X{ea} + M \cdot N /8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

10. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIDATA[\X{ea} \slice M \cdot N /8]`.

11. Let :math:`m_k` be the integer for which :math:`\bytes_{\iM}(m_k) = b^\ast[k \cdot M/8 \slice M/8]`.

12. Let :math:`W` be the integer :math:`M \cdot 2`.

13. Let :math:`n_k` be the result of computing :math:`\extend^{\sx}_{M,W}(m_k)`.

14. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\K{i}W\K{x}N}(n_0 \dots n_{N-1})`.

15. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128.\LOAD{M}\K{x}N\_\sx~x~\memarg) &\stepto&
     S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + M \cdot N / 8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & \bytes_{\iM}(m_k) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} + k \cdot M/8 \slice M/8]) \\
     \wedge & W = M \cdot 2 \\
     \wedge & c = \lanes^{-1}_{\K{i}W\K{x}N}(\extend^{\sx}_{M,W}(m_0) \dots \extend^{\sx}_{M,W}(m_{N-1})))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128.\LOAD{M}\K{x}N\K{\_}\sx~x~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-load-splat:

:math:`\V128\K{.}\LOAD{N}\K{\_splat}~x~\memarg`
...............................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-load-extend>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-load-extend>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-load-extend>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

7. Pop the value :math:`\X{at}.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

10. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIDATA[\X{ea} \slice N/8]`.

11. Let :math:`n` be the integer for which :math:`\bytes_{\iN}(n) = b^\ast`.

12. Let :math:`L` be the integer :math:`128 / N`.

13. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\IN\K{x}L}(n^L)`.

14. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128\K{.}\LOAD{N}\K{\_splat}~x~\memarg) &\stepto& S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & \bytes_{\iN}(n) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} \slice N/8] \\
     \wedge & c = \lanes^{-1}_{\IN\K{x}L}(n^L))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128.\LOAD{N}\K{\_splat}~x~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-load-zero:

:math:`\V128\K{.}\LOAD{N}\K{\_zero}~x~\memarg`
..............................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-load-extend>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-load-extend>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-load-extend>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

7. Pop the value :math:`\X{at}.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

10. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIDATA[\X{ea} \slice N/8]`.

11. Let :math:`n` be the integer for which :math:`\bytes_{\iN}(n) = b^\ast`.

12. Let :math:`c` be the result of computing :math:`\extendu_{N,128}(n)`.

13. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128\K{.}\LOAD{N}\K{\_zero}~x~\memarg) &\stepto& S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & \bytes_{\iN}(n) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} \slice N/8]) \\
     \wedge & c = \extendu_{N,128}(n)
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128.\LOAD{N}\K{\_zero}~x~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-load-lane:

:math:`\V128\K{.}\LOAD{N}\K{\_lane}~x~\memarg~y`
................................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-load-extend>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-load-extend>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-load-extend>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

7. Pop the value :math:`\V128.\CONST~v` from the stack.

8. Assert: due to :ref:`validation <valid-load-extend>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

9. Pop the value :math:`\X{at}.\CONST~i` from the stack.

10. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

11. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

12. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIDATA[\X{ea} \slice N/8]`.

13. Let :math:`r` be the constant for which :math:`\bytes_{\iN}(r) = b^\ast`.

14. Let :math:`L` be :math:`128 / N`.

15. Let :math:`j^\ast` be the result of computing :math:`\lanes_{\IN\K{x}L}(v)`.

16. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\IN\K{x}L}(j^\ast \with [y] = r)`.

17. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128.\CONST~v)~(\V128\K{.}\LOAD{N}\K{\_lane}~x~\memarg~y) &\stepto& S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & \bytes_{\iN}(r) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} \slice N/8]) \\
     \wedge & L = 128/N \\
     \wedge & c = \lanes^{-1}_{\IN\K{x}L}(\lanes_{\IN\K{x}L}(v) \with [y] = r))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128.\CONST~v)~(\V128.\LOAD{N}\K{\_lane}~x~\memarg~y) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-store:
.. _exec-storen:

:math:`t\K{.}\STORE~x~\memarg` and :math:`t\K{.}\STORE{N}~x~\memarg`
....................................................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-storen>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-storen>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-storen>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

7. Pop the value :math:`t.\CONST~c` from the stack.

8. Assert: due to :ref:`validation <valid-storen>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

9. Pop the value :math:`\X{at}.\CONST~i` from the stack.

10. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

11. If :math:`N` is not part of the instruction, then:

    a. Let :math:`N` be the :ref:`bit width <syntax-numtype>` :math:`|t|` of :ref:`number type <syntax-numtype>` :math:`t`.

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
   S; F; (\X{at}.\CONST~i)~(t.\CONST~c)~(t.\STORE~x~\memarg) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + |t|/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & S' = S \with \SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} \slice |t|/8] = \bytes_t(c)) \\[1ex]
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(t.\CONST~c)~(t.\STORE{N}~x~\memarg) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & S' = S \with \SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} \slice N/8] = \bytes_{\iN}(\wrap_{|t|,N}(c)) \\[1ex]
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(t.\CONST~c)~(t.\STORE{N}^?~x~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-store-lane:

:math:`\V128\K{.}\STORE{N}\K{\_lane}~x~\memarg~y`
.................................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-storen>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-storen>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-storen>`, a value of :ref:`value type <syntax-valtype>` :math:`\V128` is on the top of the stack.

7. Pop the value :math:`\V128.\CONST~c` from the stack.

8. Assert: due to :ref:`validation <valid-storen>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

9. Pop the value :math:`\X{at}.\CONST~i` from the stack.

10. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

11. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

12. Let :math:`L` be :math:`128/N`.

13. Let :math:`j^\ast` be the result of computing :math:`\lanes_{\IN\K{x}L}(c)`.

14. Let :math:`b^\ast` be the result of computing :math:`\bytes_{\iN}(j^\ast[y])`.

15. Replace the bytes :math:`\X{mem}.\MIDATA[\X{ea} \slice N/8]` with :math:`b^\ast`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128.\CONST~c)~(\V128.\STORE{N}\K{\_lane}~x~\memarg~y) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
     \wedge & L = 128/N \\
     \wedge & S' = S \with \SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA[\X{ea} \slice N/8] = \bytes_{\iN}(\lanes_{\IN\K{x}L}(c)[y]))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~i)~(\V128.\CONST~c)~(\V128.\STORE{N}\K{\_lane}~x~\memarg~y) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-memory.size:

:math:`\MEMORYSIZE~x`
.....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.size>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-memory.size>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Let :math:`\X{at}~\limits` be the :ref:`memory type <syntax-memtype>` :math:`\X{mem}.\MITYPE`.

7. Let :math:`\X{sz}` be the length of :math:`\X{mem}.\MIDATA` divided by the :ref:`page size <page-size>`.

8. Push the value :math:`\X{at}.\CONST~\X{sz}` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\MEMORYSIZE~x) &\stepto& S; F; (\X{at}.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| = \X{sz}\cdot64\,\F{Ki} \\
     \wedge S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MITYPE = \X{at}~\X{lim})
     \end{array} \\
   \end{array}


.. index:: determinism, non-determinism
.. _exec-memory.grow:

:math:`\MEMORYGROW~x`
.....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.grow>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-memory.grow>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Let :math:`\X{sz}` be the length of :math:`S.\SMEMS[a]` divided by the :ref:`page size <page-size>`.

7. Assert: due to :ref:`validation <valid-memory.grow>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

8. Pop the value :math:`\X{at}.\CONST~n` from the stack.

9. Let :math:`\X{err}` be the :math:`\X{at}` value :math:`2^{|\X{at}|}-1`, for which :math:`\signed_{|\X{at}|}(\X{err})` is :math:`-1`.

10. Either:

   a. If :ref:`growing <grow-mem>` :math:`\X{mem}` by :math:`n` :ref:`pages <page-size>` succeeds, then:

      i. Push the value :math:`\X{at}.\CONST~\X{sz}` to the stack.

   b. Else:

      i. Push the value :math:`\X{at}.\CONST~\X{err}` to the stack.

11. Or:

   a. Push the value :math:`\X{at}.\CONST~\X{err}` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~n)~(\MEMORYGROW~x) &\stepto& S'; F; (\X{at}.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & F.\AMODULE.\MIMEMS[x] = a \\
     \wedge & \X{sz} = |S.\SMEMS[a].\MIDATA|/64\,\F{Ki} \\
     \wedge & S' = S \with \SMEMS[a] = \growmem(S.\SMEMS[a], n)) \\[1ex]
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\X{at}.\CONST~n)~(\MEMORYGROW~x) &\stepto& S; F; (\X{at}.\CONST~\signed_{|\X{at}|}^{-1}(-1))
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

:math:`\MEMORYFILL~x`
.....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.fill>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`\X{ma}` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-memory.fill>`, :math:`S.\SMEMS[\X{ma}]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[\X{ma}]`.

6. Assert: due to :ref:`validation <valid-memory.fill>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

7. Pop the value :math:`\X{at}.\CONST~n` from the stack.

8. Assert: due to :ref:`validation <valid-memory.fill>`, a value is on the top of the stack.

9. Pop the value :math:`\val` from the stack.

10. Assert: due to :ref:`validation <valid-memory.fill>`, a value of :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

11. Pop the value :math:`\X{at}.\CONST~d` from the stack.

12. If :math:`d + n` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

13. If :math:`n = 0`, then:

    a. Return.

14. Push the value :math:`\I32.\CONST~d` to the stack.

15. Push the value :math:`\val` to the stack.

16. Execute the instruction :math:`\X{at}\K{.}\STORE\K{8}~\{ \OFFSET~0, \ALIGN~0 \}`.

17. Assert: due to the earlier check against the memory size, :math:`d+1 < 2^{32}`.

18. Push the value :math:`\X{at}.\CONST~(d+1)` to the stack.

19. Push the value :math:`\val` to the stack.

20. Push the value :math:`\X{at}.\CONST~(n-1)` to the stack.

21. Execute the instruction :math:`\MEMORYFILL~x`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\X{at}.\CONST~d)~\val~(\X{at}.\CONST~n)~\MEMORYFILL~x
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     (\iff d + n > |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA|)
   \\[1ex]
   S; F; (\X{at}.\CONST~d)~\val~(\X{at}.\CONST~0)~\MEMORYFILL~x
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\X{at}.\CONST~d)~\val~(\X{at}.\CONST~n+1)~\MEMORYFILL~x
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\X{at}.\CONST~d)~\val~(\X{at}\K{.}\STORE\K{8}~x~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\X{at}.\CONST~d+1)~\val~(\X{at}.\CONST~n)~\MEMORYFILL~x \\
       \end{array}
     \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-memory.copy:

:math:`\MEMORYCOPY~x~y`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.copy>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Assert: due to :ref:`validation <valid-memory.copy>`, :math:`F.\AMODULE.\MIMEMS[y]` exists.

4. Let :math:`\X{da}` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

5. Let :math:`\X{sa}` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[y]`.

6. Assert: due to :ref:`validation <valid-memory.copy>`, :math:`S.\SMEMS[\X{da}]` exists.

7. Assert: due to :ref:`validation <valid-memory.copy>`, :math:`S.\SMEMS[\X{sa}]` exists.

8. Let :math:`\X{mem}_d` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[\X{da}]`.

9. Let :math:`\X{mem}_s` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[\X{sa}]`.

10. Assert: due to :ref:`validation <valid-memory.copy>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}_n` is on the top of the stack.

11. Pop the value :math:`\X{at}_n.\CONST~n` from the stack.

12. Assert: due to :ref:`validation <valid-memory.copy>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}_s` is on the top of the stack.

13. Pop the value :math:`\X{at}_s.\CONST~s` from the stack.

14. Assert: due to :ref:`validation <valid-memory.copy>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}_d` is on the top of the stack.

15. Pop the value :math:`\X{at}_d.\CONST~d` from the stack.

16. If :math:`s + n` is larger than the length of :math:`\X{mem}_s.\MIDATA` or :math:`d + n` is larger than the length of :math:`\X{mem}_d.\MIDATA`, then:

    a. Trap.

17. If :math:`n = 0`, then:

   a. Return.

18. If :math:`d \leq s`, then:

   a. Push the value :math:`\X{at}_d.\CONST~d` to the stack.

   b. Push the value :math:`\X{at}_s.\CONST~s` to the stack.

   c. Execute the instruction :math:`\I32\K{.}\LOAD\K{8\_u}~y~\{ \OFFSET~0, \ALIGN~0 \}`.

   d. Execute the instruction :math:`\I32\K{.}\STORE\K{8}~x~\{ \OFFSET~0, \ALIGN~0 \}`.

   e. Assert: due to the earlier check against the memory size, :math:`d+1 < 2^{32}`.

   f. Push the value :math:`\X{at}_d.\CONST~(d+1)` to the stack.

   g. Assert: due to the earlier check against the memory size, :math:`s+1 < 2^{32}`.

   h. Push the value :math:`\X{at}_s.\CONST~(s+1)` to the stack.

19. Else:

   a. Assert: due to the earlier check against the memory size, :math:`d+n-1 < 2^{32}`.

   b. Push the value :math:`\X{at}_d.\CONST~(d+n-1)` to the stack.

   c. Assert: due to the earlier check against the memory size, :math:`s+n-1 < 2^{32}`.

   d. Push the value :math:`\X{at}_s.\CONST~(s+n-1)` to the stack.

   e. Execute the instruction :math:`\I32\K{.}\LOAD\K{8\_u}~y~\{ \OFFSET~0, \ALIGN~0 \}`.

   f. Execute the instruction :math:`\I32\K{.}\STORE\K{8}~x~\{ \OFFSET~0, \ALIGN~0 \}`.

   g. Push the value :math:`\X{at}_d.\CONST~d` to the stack.

   h. Push the value :math:`\X{at}_s.\CONST~s` to the stack.

20. Push the value :math:`\X{at}_n.\CONST~(n-1)` to the stack.

21. Execute the instruction :math:`\MEMORYCOPY~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\X{at}_x.\CONST~d)~(\X{at}_y.\CONST~s)~(\X{at}_n.\CONST~n)~\MEMORYCOPY~x~y
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & (d + n > |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIDATA| \\
      \vee & s + n > |S.\SMEMS[F.\AMODULE.\MIMEMS[y]].\MIDATA|)) \\
     \end{array}
   \\[1ex]
   S; F; (\X{at}_x.\CONST~d)~(\X{at}_y.\CONST~s)~(\X{at}_n.\CONST~0)~\MEMORYCOPY~x~y
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\X{at}_x.\CONST~d)~(\X{at}_y.\CONST~s)~(\X{at}_n.\CONST~n+1)~\MEMORYCOPY~x~y
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\X{at}_x.\CONST~d) \\
       (\X{at}_y.\CONST~s)~(\I32\K{.}\LOAD\K{8\_u}~y~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\I32\K{.}\STORE\K{8}~x~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\X{at}_x.\CONST~d+1)~(\X{at}_y.\CONST~s+1)~(\X{at}_n.\CONST~n)~\MEMORYCOPY~x~y \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d \leq s)
   \\[1ex]
   S; F; (\X{at}_x.\CONST~d)~(\X{at}_y.\CONST~s)~(\X{at}_n.\CONST~n+1)~\MEMORYCOPY~x~y
     \quad\stepto
     \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\X{at}_x.\CONST~d+n) \\
       (\X{at}_y.\CONST~s+n)~(\I32\K{.}\LOAD\K{8\_u}~y~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\I32\K{.}\STORE\K{8}~x~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\X{at}_x.\CONST~d)~(\X{at}_y.\CONST~s)~(\X{at}_n.\CONST~n)~\MEMORYCOPY~x~y \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff d > s) \\
   \end{array}


.. _exec-memory.init:

:math:`\MEMORYINIT~x~y`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-memory.init>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`\X{ma}` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-memory.init>`, :math:`S.\SMEMS[\X{ma}]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[\X{ma}]`.

6. Assert: due to :ref:`validation <valid-memory.init>`, :math:`F.\AMODULE.\MIDATAS[y]` exists.

7. Let :math:`\X{da}` be the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]`.

8. Assert: due to :ref:`validation <valid-memory.init>`, :math:`S.\SDATAS[\X{da}]` exists.

9. Let :math:`\X{data}` be the  :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]`.

10. Assert: due to :ref:`validation <valid-memory.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Assert: due to :ref:`validation <valid-memory.init>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

13. Pop the value :math:`\I32.\CONST~s` from the stack.

14. Assert: due to :ref:`validation <valid-memory.init>`, a value of some :ref:`address type <syntax-addrtype>` :math:`\X{at}` is on the top of the stack.

15. Pop the value :math:`\X{at}.\CONST~d` from the stack.

16. If :math:`s + n` is larger than the length of :math:`\X{data}.\DIDATA` or :math:`d + n` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

17. If :math:`n = 0`, then:

    a. Return.

18. Let :math:`b` be the byte :math:`\X{data}.\DIDATA[s]`.

19. Push the value :math:`\X{at}.\CONST~d` to the stack.

20. Push the value :math:`\I32.\CONST~b` to the stack.

21. Execute the instruction :math:`\I32\K{.}\STORE\K{8}~x~\{ \OFFSET~0, \ALIGN~0 \}`.

22. Assert: due to the earlier check against the memory size, :math:`d+1 < 2^{32}`.

23. Push the value :math:`\X{at}.\CONST~(d+1)` to the stack.

24. Assert: due to the earlier check against the memory size, :math:`s+1 < 2^{32}`.

25. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

26. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

27. Execute the instruction :math:`\MEMORYINIT~x~y`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   S; F; (\X{at}.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n)~(\MEMORYINIT~x~y)
     \quad\stepto\quad S; F; \TRAP
     \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & d + n > |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\DIDATA| \\
      \vee & s + n > |S.\SDATAS[F.\AMODULE.\MIDATAS[y]].\MIDATA|) \\[1ex]
     \end{array}
   \\[1ex]
   S; F; (\X{at}.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~0)~(\MEMORYINIT~x~y)
     \quad\stepto\quad S; F; \epsilon
     \\ \qquad
     (\otherwise)
   \\[1ex]
   S; F; (\X{at}.\CONST~d)~(\I32.\CONST~s)~(\I32.\CONST~n+1)~(\MEMORYINIT~x~y)
     \quad\stepto
       \\ \qquad S; F;
       \begin{array}[t]{@{}l@{}}
       (\X{at}.\CONST~d)~(\I32.\CONST~b)~(\I32\K{.}\STORE\K{8}~x~\{ \OFFSET~0, \ALIGN~0 \}) \\
       (\X{at}.\CONST~d+1)~(\I32.\CONST~s+1)~(\I32.\CONST~n)~(\MEMORYINIT~x~y) \\
       \end{array}
     \\ \qquad
     (\otherwise, \iff b = S.\SDATAS[F.\AMODULE.\MIDATAS[y]].\DIDATA[s]) \\
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

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\fblocktype_{S;F}(\blocktype)` is defined.

3. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`instruction type <syntax-instrtype>` :math:`\fblocktype_{S;F}(\blocktype)`.

4. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the block.

5. Assert: due to :ref:`validation <valid-block>`, there are at least :math:`m` values on the top of the stack.

6. Pop the values :math:`\val^m` from the stack.

7. :ref:`Enter <exec-instr-seq-enter>` the block :math:`\val^m~\instr^\ast` with label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl}
   S; F; \val^m~\BLOCK~\X{bt}~\instr^\ast~\END &\stepto&
     S; F; \LABEL_n\{\epsilon\}~\val^m~\instr^\ast~\END
     \\&&\quad (\iff \fblocktype_{S;F}(\X{bt}) = [t_1^m] \to [t_2^n])
   \end{array}


.. _exec-loop:

:math:`\LOOP~\blocktype~\instr^\ast~\END`
.........................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\fblocktype_{S;F}(\blocktype)` is defined.

3. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`instruction type <syntax-instrtype>` :math:`\fblocktype_{S;F}(\blocktype)`.

4. Let :math:`L` be the label whose arity is :math:`m` and whose continuation is the start of the loop.

5. Assert: due to :ref:`validation <valid-loop>`, there are at least :math:`m` values on the top of the stack.

6. Pop the values :math:`\val^m` from the stack.

7. :ref:`Enter <exec-instr-seq-enter>` the block :math:`\val^m~\instr^\ast` with label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl}
   S; F; \val^m~\LOOP~\X{bt}~\instr^\ast~\END &\stepto&
     S; F; \LABEL_m\{\LOOP~\X{bt}~\instr^\ast~\END\}~\val^m~\instr^\ast~\END
     \\&&\quad (\iff \fblocktype_{S;F}(\X{bt}) = [t_1^m] \to [t_2^n])
   \end{array}


.. _exec-if:

:math:`\IF~\blocktype~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
.............................................................

1. Assert: due to :ref:`validation <valid-if>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~c` from the stack.

3. If :math:`c` is non-zero, then:

   a. Execute the block instruction :math:`\BLOCK~\blocktype~\instr_1^\ast~\END`.

4. Else:

   a. Execute the block instruction :math:`\BLOCK~\blocktype~\instr_2^\ast~\END`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl}
   (\I32.\CONST~c)~\IF~\X{bt}~\instr_1^\ast~\ELSE~\instr_2^\ast~\END &\stepto&
     \BLOCK~\X{bt}~\instr_1^\ast~\END
     \\&&\quad (\iff c \neq 0) \\
   (\I32.\CONST~c)~\IF~\X{bt}~\instr_1^\ast~\ELSE~\instr_2^\ast~\END &\stepto&
     \BLOCK~\X{bt}~\instr_2^\ast~\END
     \\&&\quad (\iff c = 0) \\
   \end{array}


.. _exec-throw:

:math:`\THROW~x`
................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-throw>`, :math:`F.\AMODULE.\MITAGS[x]` exists.

3. Let :math:`\X{ta}` be the :ref:`tag address <syntax-tagaddr>` :math:`F.\AMODULE.\MITAGS[x]`.

4. Assert: due to :ref:`validation <valid-throw>`, :math:`S.\STAGS[\X{ta}]` exists.

5. Let :math:`\X{ti}` be the :ref:`tag instance <syntax-taginst>` :math:`S.\STAGS[\X{ta}]`.

6. Let :math:`[t^n] \toF [{t'}^\ast]` be the :ref:`tag type <syntax-tagtype>` :math:`\X{ti}.\TAGITYPE`.

7. Assert: due to :ref:`validation <valid-throw>`, there are at least :math:`n` values on the top of the stack.

8. Pop the :math:`n` values :math:`\val^n` from the stack.

9. Let :math:`\X{exn}` be the :ref:`exception instance <syntax-exninst>` :math:`\{\EITAG~\X{ta}, \EIFIELDS~\val^n\}`.

10. Let :math:`\X{ea}` be the length of :math:`S.\SEXNS`.

11. Append :math:`\X{exn}` to :math:`S.\SEXNS`.

12. Push the value :math:`\REFEXNADDR~\X{ea}` to the stack.

13. Execute the instruction |THROWREF|.

.. math::
   ~\\[-1ex]
   \begin{array}{lclr@{\qquad}l}
   S; F; \val^n~(\THROW~x) &\stepto& S'; F; (\REFEXNADDR~|S.\SEXNS|)~\THROWREF &
     (\begin{array}[t]{@{}r@{~}l@{}}
      \iff & F.\AMODULE.\MITAGS[x] = a \\
      \land & S.\STAGS[a].\TAGITYPE = [t^n] \toF [] \\
      \land & \X{exn} = \{ \EITAG~a, \EIFIELDS~\val^n \} \\
      \land & S' = S \with \SEXNS = S.\SEXNS~\X{exn} ) \\
      \end{array} \\
   \end{array}


.. _exec-throw_ref:

:math:`\THROWREF`
.................

1. Assert: due to :ref:`validation <valid-throw_ref>`, a :ref:`reference <syntax-ref>` is on the top of the stack.

2. Pop the reference :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. Trap.

4. Assert: due to :ref:`validation <valid-throw_ref>`, :math:`\reff` is an :ref:`exception reference <syntax-ref.exn>`.

5. Let :math:`\REFEXNADDR~\X{ea}` be :math:`\reff`.

6. Assert: due to :ref:`validation <valid-throw_ref>`, :math:`S.\SEXNS[\X{ea}]` exists.

7. Let :math:`\X{exn}` be the :ref:`exception instance <syntax-exninst>` :math:`S.\SEXNS[\X{ea}]`.

8. Let :math:`a` be the :ref:`tag address <syntax-tagaddr>` :math:`\X{exn}.\EITAG`.

9. While the stack is not empty and the top of the stack is not an :ref:`exception handler <syntax-handler>`, do:

   a. Pop the top element from the stack.

10. Assert: the stack is now either empty, or there is an exception handler on the top of the stack.

11. If the stack is empty, then:

   a. Return the exception :math:`(\REFEXNADDR~a)` as a :ref:`result <syntax-result>`.

12. Assert: there is an :ref:`exception handler <syntax-handler>` on the top of the stack.

13. Pop the exception handler  :math:`\HANDLER_n\{\catch^\ast\}` from the stack.

14. If :math:`\catch^\ast` is empty, then:

    a. Push the exception reference :math:`\REFEXNADDR~\X{ea}` back to the stack.

    b. Execute the instruction |THROWREF| again.

15. Else:

    a. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

    b. Let :math:`\catch_1` be the first :ref:`catch clause <syntax-catch>` in :math:`\catch^\ast` and :math:`{\catch'}^\ast` the remaining clauses.

    c. If :math:`\catch_1` is of the form :math:`\CATCH~x~l` and the :ref:`tag address <syntax-tagaddr>` :math:`a` equals :math:`F.\AMODULE.\MITAGS[x]`, then:

       i. Push the values :math:`\X{exn}.\EIFIELDS` to the stack.

       ii. Execute the instruction :math:`\BR~l`.

    d. Else if :math:`\catch_1` is of the form :math:`\CATCHREF~x~l` and the :ref:`tag address <syntax-tagaddr>` :math:`a` equals :math:`F.\AMODULE.\MITAGS[x]`, then:

       i. Push the values :math:`\X{exn}.\EIFIELDS` to the stack.

       ii. Push the exception reference :math:`\REFEXNADDR~\X{ea}` to the stack.

       iii. Execute the instruction :math:`\BR~l`.

    e. Else if :math:`\catch_1` is of the form :math:`\CATCHALL~l`, then:

       i. Execute the instruction :math:`\BR~l`.

    f. Else if :math:`\catch_1` is of the form :math:`\CATCHALLREF~l`, then:

       i. Push the exception reference :math:`\REFEXNADDR~\X{ea}` to the stack.

       ii. Execute the instruction :math:`\BR~l`.

    g. Else:

       1. Push the modified handler  :math:`\HANDLER_n\{{\catch'}^\ast\}` back to the stack.

       2. Push the exception reference :math:`\REFEXNADDR~\X{ea}` back to the stack.

       3. Execute the instruction :math:`\THROWREF` again.

.. math::
   ~\\[-1ex]
   \begin{array}{rcl}
   (\REFNULL~\X{ht})~\THROWREF &\stepto&
     \TRAP \\
   \HANDLER_n\{\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END &\stepto&
     (\REFEXNADDR~a)~\THROWREF \\
   S; F; \HANDLER_n\{(\CATCH~x~l)~\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END &\stepto&
     \X{exn}.\EIFIELDS~(\BR~l) \\ &&
     (\begin{array}[t]{@{}r@{~}l@{}}
      \iff & \X{exn} = S.\SEXNS[a] \\
      \land & \X{exn}.\EITAG = F.\AMODULE.\MITAGS[x]) \\
      \end{array} \\
   S; F; \HANDLER_n\{(\CATCHREF~x~l)~\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END &\stepto&
     \X{exn}.\EIFIELDS~(\REFEXNADDR~a)~(\BR~l) \\ &&
     (\begin{array}[t]{@{}r@{~}l@{}}
      \iff & \X{exn} = S.\SEXNS[a] \\
      \land & \X{exn}.\EITAG = F.\AMODULE.\MITAGS[x]) \\
      \end{array} \\
   \HANDLER_n\{(\CATCHALL~l)~\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END &\stepto&
     (\BR~l) \\
   \HANDLER_n\{(\CATCHALLREF~l)~\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END &\stepto&
     (\REFEXNADDR~a)~(\BR~l) \\
   \HANDLER_n\{\catch_1~\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END &\stepto&
     \HANDLER_n\{\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END \\ &&
     (\otherwise) \\
   \end{array}


.. _exec-try_table:

:math:`\TRYTABLE~\blocktype~\catch^\ast~\instr^\ast~\END`
.........................................................

1. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\fblocktype_{S;F}(\blocktype)` is defined.

2. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`instruction type <syntax-instrtype>` :math:`\fblocktype_{S;F}(\blocktype)`.

3. Assert: due to :ref:`validation <valid-try_table>`, there are at least :math:`m` values on the top of the stack.

4. Pop the values :math:`\val^m` from the stack.

5. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the |TRYTABLE| instruction.

6. :ref:`Enter <exec-handler-enter>` the block :math:`\val^m~\instr_1^\ast` with label :math:`L` and exception handler :math:`\HANDLER_n\{\catch^\ast\}`.

.. math::
   ~\\[-1ex]
   \begin{array}{r}
   F; \val^m~(\TRYTABLE~\X{bt}~\catch^\ast~\instr^\ast~\END
   \quad \stepto \quad
   F; \HANDLER_n\{\catch^\ast\}~(\LABEL_n\{\epsilon\}~\val^m~\instr^\ast~\END)~\END \\ \qquad\qquad
   (\iff \fblocktype_{S;F}(\X{bt}) = [t_1^m] \to [t_2^n] \land (F.\AMODULE.\MITAGS[x]=a_x)^\ast)
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

   a. While the top of the stack is a value or a :ref:`handler <syntax-handler>`, do:

      i. Pop the value or handler from the stack.

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

   a. :ref:`Execute <exec-br>` the instruction :math:`\BR~l`.

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

1. Assert: due to :ref:`validation <valid-br_table>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~i` from the stack.

3. If :math:`i` is smaller than the length of :math:`l^\ast`, then:

   a. Let :math:`l_i` be the label :math:`l^\ast[i]`.

   b. :ref:`Execute <exec-br>` the instruction :math:`\BR~l_i`.

4. Else:

   a. :ref:`Execute <exec-br>` the instruction :math:`\BR~l_N`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   (\I32.\CONST~i)~(\BRTABLE~l^\ast~l_N) &\stepto& (\BR~l_i)
     & (\iff l^\ast[i] = l_i) \\
   (\I32.\CONST~i)~(\BRTABLE~l^\ast~l_N) &\stepto& (\BR~l_N)
     & (\iff |l^\ast| \leq i) \\
   \end{array}


.. _exec-br_on_null:

:math:`\BRONNULL~l`
...................

1. Assert: due to :ref:`validation <valid-ref.is_null>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

4. Else:

   a. Push the value :math:`\reff` back to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \reff~(\BRONNULL~l) &\stepto& (\BR~l)
     & (\iff \reff = \REFNULL~\X{ht}) \\
   \reff~(\BRONNULL~l) &\stepto& \reff
     & (\otherwise) \\
   \end{array}


.. _exec-br_on_non_null:

:math:`\BRONNONNULL~l`
......................

1. Assert: due to :ref:`validation <valid-ref.is_null>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. Do nothing.

4. Else:

   a. Push the value :math:`\reff` back to the stack.

   b. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \reff~(\BRONNONNULL~l) &\stepto& \epsilon
     & (\iff \reff = \REFNULL~\X{ht}) \\
   \reff~(\BRONNONNULL~l) &\stepto& \reff~(\BR~l)
     & (\otherwise) \\
   \end{array}


.. _exec-br_on_cast:

:math:`\BRONCAST~l~\X{rt}_1~\X{rt}_2`
.....................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`\X{rt}'_2` be the :ref:`reference type <syntax-reftype>` :math:`\insttype_{F.\AMODULE}(\X{rt}_2)`.

3. Assert: due to :ref:`validation <valid-ref.test>`, :math:`\X{rt}'_2` is :ref:`closed <type-closed>`.

4. Assert: due to :ref:`validation <valid-ref.test>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

5. Pop the value :math:`\reff` from the stack.

6. Assert: due to validation, the :ref:`reference value <syntax-ref>` is :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>`.

7. Let :math:`\X{rt}` be the :ref:`reference type <syntax-reftype>` of :math:`\reff`.

8. Push the value :math:`\reff` back to the stack.

9. If the :ref:`reference type <syntax-reftype>` :math:`\X{rt}` :ref:`matches <match-reftype>` :math:`\X{rt}'_2`, then:

   a. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; F; \reff~(\BRONCAST~l~\X{rt}_1~\X{rt}_2) &\stepto& \reff~(\BR~l)
     & (\iff S \vdashval \reff : \X{rt}
        \land {} \vdashreftypematch \X{rt} \matchesreftype \insttype_{F.\AMODULE}(\X{rt}_2)) \\
   S; F; \reff~(\BRONCAST~l~\X{rt}_1~\X{rt}_2) &\stepto& \reff
     & (\otherwise) \\
   \end{array}


.. _exec-br_on_cast_fail:

:math:`\BRONCASTFAIL~l~\X{rt}_1~\X{rt}_2`
.........................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`\X{rt}'_2` be the :ref:`reference type <syntax-reftype>` :math:`\insttype_{F.\AMODULE}(\X{rt}_2)`.

3. Assert: due to :ref:`validation <valid-ref.test>`, :math:`\X{rt}'_2` is :ref:`closed <type-closed>`.

4. Assert: due to :ref:`validation <valid-ref.test>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

5. Pop the value :math:`\reff` from the stack.

6. Assert: due to validation, the :ref:`reference value <syntax-ref>` is :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>`.

7. Let :math:`\X{rt}` be the :ref:`reference type <syntax-reftype>` of :math:`\reff`.

8. Push the value :math:`\reff` back to the stack.

9. If the :ref:`reference type <syntax-reftype>` :math:`\X{rt}` does not :ref:`match <match-reftype>` :math:`\X{rt}'_2`, then:

   a. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   S; F; \reff~(\BRONCASTFAIL~l~\X{rt}_1~\X{rt}_2) &\stepto& \reff
     & (\iff S \vdashval \reff : \X{rt}
        \land {} \vdashreftypematch \X{rt} \matchesreftype \insttype_{F.\AMODULE}(\X{rt}_2)) \\
   S; F; \reff~(\BRONCASTFAIL~l~\X{rt}_1~\X{rt}_2) &\stepto& \reff~(\BR~l)
     & (\otherwise) \\
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
   \FRAME_n\{F\}~B^\ast[\val^n~\RETURN]~\END &\stepto& \val^n
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


.. _exec-call_ref:

:math:`\CALLREF~x`
..................

1. Assert: due to :ref:`validation <valid-call_ref>`, a null or :ref:`function reference <syntax-ref>` is on the top of the stack.

2. Pop the reference value :math:`r` from the stack.

3. If :math:`r` is :math:`\REFNULL~\X{ht}`, then:

    a. Trap.

4. Assert: due to :ref:`validation <valid-call_ref>`, :math:`r` is a :ref:`function reference <syntax-ref>`.

5. Let :math:`\REFFUNCADDR~a` be the reference :math:`r`.

6. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\REFFUNCADDR~a)~(\CALLREF~x) &\stepto& F; (\INVOKE~a) \\
   F; (\REFNULL~\X{ht})~(\CALLREF~x) &\stepto& F; \TRAP \\
   \end{array}


.. _exec-call_indirect:

:math:`\CALLINDIRECT~x~y`
.........................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\STABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITYPES[y]` is defined.

7. Let :math:`\X{dt}_{\F{expect}}` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[y]`.

8. Assert: due to :ref:`validation <valid-call_indirect>`, a value with :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

11. Let :math:`r` be the :ref:`reference <syntax-ref>` :math:`\X{tab}.\TIELEM[i]`.

12. If :math:`r` is :math:`\REFNULL~\X{ht}`, then:

    a. Trap.

13. Assert: due to :ref:`validation of table mutation <valid-table.set>`, :math:`r` is a :ref:`function reference <syntax-ref.func>`.

14. Let :math:`\REFFUNCADDR~a` be the :ref:`function reference <syntax-ref.func>` :math:`r`.

15. Assert: due to :ref:`validation of table mutation <valid-table.set>`, :math:`S.\SFUNCS[a]` exists.

16. Let :math:`\X{f}` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[a]`.

17. Let :math:`\X{dt}_{\F{actual}}` be the :ref:`defined type <syntax-deftype>` :math:`\X{f}.\FITYPE`.

18. If :math:`\X{dt}_{\F{actual}}` does not :ref:`match <match-deftype>` :math:`\X{dt}_{\F{expect}}`, then:

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
     \wedge & S \vdashdeftypematch f.\FITYPE \matchesdeftype F.\AMODULE.\MITYPES[y])
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\CALLINDIRECT~x~y) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise)
   \end{array}


.. _exec-return_call:

:math:`\RETURNCALL~x`
.....................

.. todo: find a way to reuse call/call_indirect prose for tail call versions

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call>`, :math:`F.\AMODULE.\MIFUNCS[x]` exists.

3. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`F.\AMODULE.\MIFUNCS[x]`.

4. :ref:`Tail-invoke <exec-return-invoke>` the function instance at address :math:`a`.


.. math::
   \begin{array}{lcl@{\qquad}l}
   (\RETURNCALL~x) &\stepto& (\RETURNINVOKE~a)
     & (\iff (\CALL~x) \stepto (\INVOKE~a))
   \end{array}


.. _exec-return_call_ref:

:math:`\RETURNCALLREF~x`
........................

1. Assert: due to :ref:`validation <valid-return_call_ref>`, a :ref:`function reference <syntax-ref>` is on the top of the stack.

2. Pop the reference value :math:`r` from the stack.

3. If :math:`r` is :math:`\REFNULL~\X{ht}`, then:

    a. Trap.

4. Assert: due to :ref:`validation <valid-call_ref>`, :math:`r` is a :ref:`function reference <syntax-ref>`.

5. Let :math:`\REFFUNCADDR~a` be the reference :math:`r`.

6. :ref:`Tail-invoke <exec-return-invoke>` the function instance at address :math:`a`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \val~(\RETURNCALLREF~x) &\stepto& (\RETURNINVOKE~a)
     & (\iff \val~(\CALLREF~x) \stepto (\INVOKE~a)) \\
   \val~(\RETURNCALLREF~x) &\stepto& \TRAP
     & (\iff \val~(\CALLREF~x) \stepto \TRAP) \\
   \end{array}


.. _exec-return_call_indirect:

:math:`\RETURNCALLINDIRECT~x~y`
...............................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\STABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITYPES[y]` exists.

7. Let :math:`\X{dt}_{\F{expect}}` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[y]`.

8. Assert: due to :ref:`validation <valid-call_indirect>`, a value with :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

11. If :math:`\X{tab}.\TIELEM[i]` is uninitialized, then:

    a. Trap.

12. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`\X{tab}.\TIELEM[i]`.

13. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\SFUNCS[a]` exists.

14. Let :math:`\X{f}` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[a]`.

15. Let :math:`\X{dt}_{\F{actual}}` be the :ref:`defined type <syntax-functype>` :math:`\X{f}.\FITYPE`.

16. If :math:`\X{dt}_{\F{actual}}` does not :ref:`match <match-functype>` :math:`\X{dt}_{\F{expect}}`, then:

    a. Trap.

17. :ref:`Tail-invoke <exec-return-invoke>` the function instance at address :math:`a`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \val~(\RETURNCALLINDIRECT~x~y) &\stepto& (\RETURNINVOKE~a)
     & (\iff \val~(\CALLINDIRECT~x~y) \stepto (\INVOKE~a)) \\
   \val~(\RETURNCALLINDIRECT~x~y) &\stepto& \TRAP
     & (\iff \val~(\CALLINDIRECT~x~y) \stepto \TRAP) \\
   \end{array}


.. index:: instruction, instruction sequence, block, exception, trap
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

When the end of a block is reached without a jump, :ref:`exception <exception>`, or :ref:`trap <trap>` aborting it, then the following steps are performed.

1. Pop all values :math:`\val^\ast` from the top of the stack.

2. Assert: due to :ref:`validation <valid-instr-seq>`, the label :math:`L` is now on the top of the stack.

3. Pop the label from the stack.

4. Push :math:`\val^\ast` back to the stack.

5. Jump to the position after the |END| of the :ref:`structured control instruction <syntax-instr-control>` associated with the label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   \LABEL_n\{\instr^\ast\}~\val^\ast~\END &\stepto& \val^\ast
   \end{array}

.. note::
   This semantics also applies to the instruction sequence contained in a |LOOP| instruction.
   Therefore, execution of a loop falls off the end, unless a backwards branch is performed explicitly.


.. index:: exception, handler, throw context, tag, exception tag

.. _exec-handler:

Exception Handling
~~~~~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of entering and exiting |TRYTABLE| blocks.

.. _exec-handler-enter:

Entering :math:`\instr^\ast` with label :math:`L` and exception handler :math:`H`
.................................................................................

1. Push :math:`H` to the stack.

2. Push :math:`L` onto the stack.

3. Jump to the start of the instruction sequence :math:`\instr^\ast`.


.. note::
   No formal reduction rule is needed for entering an exception :ref:`handler <syntax-handler>`
   because it is an :ref:`administrative instruction <syntax-instr-admin>`
   that the |TRYTABLE| instruction reduces to directly.

.. _exec-handler-exit:

Exiting an exception handler
............................

When the end of a |TRYTABLE| block is reached without a jump, :ref:`exception <exception>`, or :ref:`trap <trap>`, then the following steps are performed.

1. Let :math:`m` be the number of values on the top of the stack.

2. Pop the values :math:`\val^m` from the stack.

3. Assert: due to :ref:`validation <valid-instr-seq>`, a handler and a label are now on the top of the stack.

4. Pop the label from the stack.

5. Pop the handler :math:`H` from the stack.

6. Push :math:`\val^m` back to the stack.

7. Jump to the position after the |END| of the administrative instruction associated with the handler :math:`H`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   \HANDLER_m\{\catch^\ast\}~\val^m~\END &\stepto& \val^m \\
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

3. Let :math:`\TFUNC~[t_1^n] \toF [t_2^m]` be the :ref:`composite type <syntax-comptype>` :math:`\expanddt(\X{f}.\FITYPE)`.

4. Let :math:`\local^\ast` be the list of :ref:`locals <syntax-local>` :math:`f.\FICODE.\FLOCALS`.

5. Let :math:`\instr^\ast~\END` be the :ref:`expression <syntax-expr>` :math:`f.\FICODE.\FBODY`.

6. Assert: due to :ref:`validation <valid-call>`, :math:`n` values are on the top of the stack.

7. Pop the values :math:`\val^n` from the stack.

8. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~f.\FIMODULE, \ALOCALS~\val^n~(\default_t)^\ast \}`.

9. Push the activation of :math:`F` with arity :math:`m` to the stack.

10. Let :math:`L` be the :ref:`label <syntax-label>` whose arity is :math:`m` and whose continuation is the end of the function.

11. :ref:`Enter <exec-instr-seq-enter>` the instruction sequence :math:`\instr^\ast` with label :math:`L`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\INVOKE~a) &\stepto& S; \FRAME_m\{F\}~\LABEL_m\{\}~\instr^\ast~\END~\END
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\SFUNCS[a] = f \\
     \wedge & \expanddt(f.\FITYPE) = \TFUNC~[t_1^n] \toF [t_2^m] \\
     \wedge & f.\FICODE = \{ \FTYPE~x, \FLOCALS~\{\LTYPE~t\}^k, \FBODY~\instr^\ast~\END \} \\
     \wedge & F = \{ \AMODULE~f.\FIMODULE, ~\ALOCALS~\val^n~(\default_t)^k \})
     \end{array} \\
   \end{array}

.. note::
   For non-defaultable types, the respective local is left uninitialized by these rules.


.. _exec-return-invoke:

Tail-invocation of :ref:`function address <syntax-funcaddr>` :math:`a`
......................................................................

1. Assert: due to :ref:`validation <valid-call>`, :math:`S.\SFUNCS[a]` exists.

2. Let :math:`\TFUNC~[t_1^n] \toF [t_2^m]` be the :ref:`composite type <syntax-comptype>` :math:`\expanddt(S.\SFUNCS[a].\FITYPE)`.

3. Assert: due to :ref:`validation <valid-return_call>`, there are at least :math:`n` values on the top of the stack.

4. Pop the results :math:`\val^n` from the stack.

5. Assert: due to :ref:`validation <valid-return_call>`, the stack contains at least one :ref:`frame <syntax-frame>`.

6. While the top of the stack is not a frame, do:

   a. Pop the top element from the stack.

7. Assert: the top of the stack is a frame.

8. Pop the frame from the stack.

9. Push :math:`\val^n` to the stack.

10. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
    S; \FRAME_m\{F\}~B^\ast[\val^n~(\RETURNINVOKE~a)]~\END &\stepto&
      \val^n~(\INVOKE~a)
      & (\iff \expanddt(S.\SFUNCS[a].\FITYPE) = \TFUNC~[t_1^n] \toF [t_2^m])
   \end{array}


.. _exec-invoke-exit:

Returning from a function
.........................

When the end of a function is reached without a jump (including through |RETURN|), or an :ref:`exception <exception>` or :ref:`trap <trap>` aborting it, then the following steps are performed.

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
It may either terminate with a :ref:`trap <trap>`, an :ref:`exception <exception>`, or return regularly.
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
     (\iff & S.\SFUNCS[a] = \{ \FITYPE~\deftype, \FIHOSTCODE~\X{hf} \} \\
     \wedge & \expanddt(\deftype) = \TFUNC~[t_1^n] \toF [t_2^m] \\
     \wedge & (S'; \result) \in \X{hf}(S; \val^n)) \\
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\INVOKE~a) &\stepto& S; \val^n~(\INVOKE~a)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\SFUNCS[a] = \{ \FITYPE~\deftype, \FIHOSTCODE~\X{hf} \} \\
     \wedge & \expanddt(\deftype) = \TFUNC~[t_1^n] \toF [t_2^m] \\
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
