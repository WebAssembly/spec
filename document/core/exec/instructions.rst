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
   No formal reduction rule is required for this instruction, since |CONST| instructions coincide with :ref:`values <syntax-val>`.


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


.. index:: SIMD instruction
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-simd:

SIMD Instructions
~~~~~~~~~~~~~~~~~~~~

SIMD instructions are defined in terms of generic numeric operators applied lane-wise based on the :ref:`shape <syntax-simd-shape>`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{t\K{x}N}(n_1,\dots,n_k) &=&
     \lanes^{-1}_{t\K{x}N}(op_t(\lanes_{t\K{x}N}(n_1) ~\dots~ \lanes_{t\K{x}N}(n_k))
   \end{array}

.. note::
   For example, the result of instruction :math:`\K{i32x4}.\ADD` applied to operands :math:`i_1, i_2`
   invokes :math:`\ADD_{\K{i32x4}}(i_1, i_2)`, which maps to
   :math:`\lanes^{-1}_{\K{i32x4}}(\ADD_{\I32}(i_1^+, i_2^+))`,
   where :math:`i_1^+` and :math:`i_2^+` are sequences resulting from invoking
   :math:`\lanes_{\K{i32x4}}(i_1)` and :math:`\lanes_{\K{i32x4}}(i_2)`
   respectively.


.. _exec-simd-const:

:math:`\V128\K{.}\VCONST~c`
...........................

1. Push the value :math:`\V128.\VCONST~c` to the stack.

.. note::
   No formal reduction rule is required for this instruction, since |VCONST| instructions coincide with :ref:`values <syntax-val>`.


.. _exec-vsunop:

:math:`\V128\K{.}\vsunop`
.........................

1. Assert: due to :ref:`validation <valid-vsunop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`c` be the result of computing :math:`\vsunop_{\I128}(c_1)`.

4. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~\V128\K{.}\vsunop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c = \vsunop_{\I128}(c_1)) \\
   \end{array}


.. _exec-vsbinop:

:math:`\V128\K{.}\vsbinop`
..........................

1. Assert: due to :ref:`validation <valid-vsbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`c` be the result of computing :math:`\vsbinop_{\I128}(c_1, c_2)`.

5. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\V128\K{.}\vsbinop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c = \vsbinop_{\I128}(c_1, c_2)) \\
   \end{array}


.. _exec-vsternop:

:math:`\V128\K{.}\vsternop`
...........................

1. Assert: due to :ref:`validation <valid-vsternop>`, three values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_3` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`c` be the result of computing :math:`\vsternop_{\I128}(c_1, c_2, c_3)`.

6. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~(\V128\K{.}\VCONST~c_3)~\V128\K{.}\vsternop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c = \vsternop_{\I128}(c_1, c_2, c_3)) \\
   \end{array}


.. _exec-simd-any_true:

:math:`\V128\K{.}\ANYTRUE`
...........................

1. Assert: due to :ref:`validation <valid-vitestop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`i` be the result of computing :math:`\ine_{128}(c_1, 0)`.

4. Push the value :math:`\I32.\CONST~i` onto the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~\V128\K{.}\ANYTRUE &\stepto& (\I32\K{.}\CONST~i)
     & (\iff i = \ine_{128}(c_1, 0)) \\
   \end{array}


.. _exec-simd-swizzle:

:math:`\K{i8x16.}\SWIZZLE`
..........................

1. Assert: due to :ref:`validation <valid-vbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Let :math:`i^\ast` be the sequence :math:`\lanes_{i8x16}(c_2)`.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`j^\ast` be the sequence :math:`\lanes_{i8x16}(c_1)`.

6. Let :math:`c^\ast` be the concatenation of the two sequences :math:`j^\ast~0^{240}`

7. Let :math:`c'` be the result of :math:`\lanes^{-1}_{i8x16}(c^\ast[ i^\ast[0] ] \dots c^\ast[ i^\ast[15] ])`.

8. Push the value :math:`\V128.\VCONST~c'` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\V128\K{.}\SWIZZLE &\stepto& (\V128\K{.}\VCONST~c')
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{i8x16}(c_2) \\
      \wedge & c^\ast = \lanes_{i8x16}(c_1)~0^{240} \\
      \wedge & c' = \lanes^{-1}_{i8x16}(c^\ast[ i^\ast[0] ] \dots c^\ast[ i^\ast[15] ])
     \end{array}
   \end{array}


.. _exec-simd-shuffle:

:math:`\K{i8x16.}\SHUFFLE~x^\ast`
.................................

1. Assert: due to :ref:`validation <valid-simd-shuffle>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Assert: due to :ref:`validation <valid-simd-shuffle>`, for all :math:`x_i` in :math:`x^\ast` it holds that :math:`x_i < 32`.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Let :math:`i_2^\ast` be the sequence :math:`\lanes_{i8x16}(c_2)`.

5. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

6. Let :math:`i_1^\ast` be the sequence :math:`\lanes_{i8x16}(c_1)`.

7. Let :math:`i^\ast` be the concatenation of the two sequences :math:`i_1^\ast~i_2^\ast`.

8. Let :math:`c` be the result of :math:`\lanes^{-1}_{i8x16}(i^\ast[x^\ast[0]] \dots i^\ast[x^\ast[15]])`.

9. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\V128\K{.}\SHUFFLE~x^\ast &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{i8x16}(c_1)~\lanes_{i8x16}(c_2) \\
      \wedge & c = \lanes^{-1}_{i8x16}(i^\ast[x^\ast[0]] \dots i^\ast[x^\ast[15]])
     \end{array}
   \end{array}


.. _exec-simd-splat:

:math:`\shape\K{.}\SPLAT`
.........................

1. Let :math:`t` be the type :math:`\unpacked(\shape)`.

2. Assert: due to :ref:`validation <valid-simd-splat>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

3. Pop the value :math:`t.\CONST~c_1` from the stack.

4. Let :math:`N` be the integer :math:`\dim(\shape)`.

5. Let :math:`c` be the result of :math:`\lanes^{-1}_{\shape}(c_1^N)`.

6. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~\shape\K{.}\SPLAT &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff t = \unpacked(\shape)
       \wedge c = \lanes^{-1}_{\shape}(c_1^{\dim(\shape)}))
     \\
   \end{array}


.. _exec-simd-extract_lane:

:math:`t_1\K{x}N\K{.}\EXTRACTLANE\K{\_}\sx^?~x`
...............................................

1. Assert: due to :ref:`validation <valid-simd-extract_lane>`, :math:`x < N`.

2. Assert: due to :ref:`validation <valid-simd-extract_lane>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the sequence :math:`\lanes_{t_1\K{x}N}(c_1)`.

5. Let :math:`t_2` be the type :math:`\unpacked(t_1\K{x}N)`.

6. Let :math:`c_2` be the result of computing :math:`\extend^{sx^?}_{t_1,t_2}(i^\ast[x])`.

7. Push the value :math:`t_2.\CONST~c_2` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_1\K{x}N\K{.}\EXTRACTLANE~x &\stepto& (t_2\K{.}\CONST~c_2)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & t_2 = \unpacked(t_1\K{x}N) \\
       \wedge & c_2 = \extend^{sx^?}_{t_1,t_2}(\lanes_{t_1\K{x}N}(c_1)[x])
     \end{array}
   \end{array}


.. _exec-simd-replace_lane:

:math:`\shape\K{.}\REPLACELANE~x`
.................................

1. Assert: due to :ref:`validation <valid-simd-replace_lane>`, :math:`x < \dim(\shape)`.

2. Let :math:`t_1` be the type :math:`\unpacked(\shape)`.

3. Assert: due to :ref:`validation <valid-simd-replace_lane>`, a value of :ref:`value type <syntax-valtype>` :math:`t_1` is on the top of the stack.

4. Pop the value :math:`t_1.\CONST~c_1` from the stack.

5. Assert: due to :ref:`validation <valid-simd-replace_lane>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

6. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

7. Let :math:`i^\ast` be the sequence :math:`\lanes_{\shape}(c_2)`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\shape}(i^\ast \with [x] = c_1)`

9. Push :math:`\V128.\VCONST~c` on the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (t_1\K{.}\CONST~c_1)~(\V128\K{.}\VCONST~c_2)~\shape\K{.}\REPLACELANE~x &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{\shape}(c_2)) \\
       \wedge & c = \lanes^{-1}_{\shape}(i^\ast \with [x] = c_1)
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
   (\V128\K{.}\VCONST~c_1)~\V128\K{.}\vunop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c = \vunop_{\shape}(c_1))
   \end{array}


.. _exec-vbinop:

:math:`\shape\K{.}\vbinop`
..........................

1. Assert: due to :ref:`validation <valid-vbinop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. If :math:`\vbinop_{\shape}(c_1, c_2)` is defined:

   a. Let :math:`c` be a possible result of computing :math:`\vbinop_{\shape}(c_1, c_2)`.

   b. Push the value :math:`\V128.\VCONST~c` to the stack.

5. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\V128\K{.}\vbinop &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff c \in \vbinop_{\shape}(c_1, c_2)) \\
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\V128\K{.}\vbinop &\stepto& \TRAP
     & (\iff \vbinop_{\shape}(c_1, c_2) = \{\})
   \end{array}


.. _exec-vshiftop:

:math:`t\K{x}N\K{.}\vshiftop`
.............................

1. Assert: due to :ref:`validation <valid-vshiftop>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~s` from the stack.

3. Assert: due to :ref:`validation <valid-vshiftop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`i^\ast` be the sequence :math:`\lanes_{t\K{x}N}(c_1)`.

6. Let :math:`c` be :math:`\lanes^{-1}_{t\K{x}N}(\vshiftop_{t}(i^\ast, s^N))`.

7. Push the value :math:`\V128.\VCONST~c` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\I32\K{.}\CONST~s)~t\K{x}N\K{.}\vshiftop &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i^\ast = \lanes_{t\K{x}N}(c_1) \\
     \wedge & c = \lanes^{-1}_{t\K{x}N}(\vshiftop_{t}(i^\ast, s^N)))
     \end{array}
   \end{array}


.. _exec-vitestop:
.. _exec-simd-all_true:

:math:`\shape\K{.}\ALLTRUE`
...........................

1. Assert: due to :ref:`validation <valid-vitestop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`i_1^\ast` be the sequence :math:`\lanes_{\shape}(c_1)`

4. Let :math:`i` be the result of computing :math:`\bool(\bigwedge(i_1 \neq 0)^\ast)`.

5. Push the value :math:`\I32.\CONST~i` onto the stack.


.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~\shape\K{.}\ALLTRUE &\stepto& (\I32\K{.}\CONST~i)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i_1^\ast = \lanes_{\shape}(c) \\
     \wedge & i = \bool(\bigwedge(i_1 \neq 0)^\ast)
     \end{array}
   \end{array}


.. _exec-simd-bitmask:

:math:`t\K{x}N\K{.}\BITMASK`
............................

1. Assert: due to :ref:`validation <valid-vitestop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`i_1^N` be the sequence :math:`\lanes_{t\K{x}N}(c)`.

4. Let :math:`B` be the :ref:`bit width <syntax-valtype>` :math:`|t|` of :ref:`value type <syntax-valtype>` :math:`t`.

5. Let :math:`i_2^N` be the sequence as a result of computing :math:`\ilts_{B}(i_1^N, 0^N)`.

6. Let :math:`c` be the integer :math:`\ibits_{32}^{-1}(i_2^N~0^{32-N})`.

7. Push the value :math:`\I32.\CONST~c` onto the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t\K{x}N\K{.}\BITMASK &\stepto& (\I32\K{.}\CONST~c)
     & (\iff c = \ibits_{32}^{-1}(\ilts_{|t|}(\lanes_{t\K{x}N}(c), 0^N)))
     \\
   \end{array}


.. _exec-vcvtop:

:math:`t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx`
.....................................................

1. Assert: due to :ref:`validation <valid-vcvtop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`i^\ast` be the sequence :math:`\lanes_{t_1\K{x}M}(c_1)`.

4. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(\vcvtop^{\sx}_{M,N}(i^\ast))`

5. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i^\ast = \lanes_{t_1\K{x}M}(c_1) \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(\vcvtop^{\sx}_{M,N}(i^\ast))
     \end{array}
   \end{array}


.. _exec-simd-narrow:

:math:`t_2\K{x}N\K{.}\NARROW\K{\_}t_1\K{x}M\K{\_}\sx`
.....................................................

1. Assert: due to :ref:`syntax <syntax-instr-simd>`, :math:`N = 2\cdot M`.

2. Assert: due to :ref:`validation <valid-vitestop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Let :math:`d_2^M` be the result of computing :math:`\narrow^{\sx}_{M,N}(\lanes_{t_1\K{x}M}(c_2))`.

5. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

6. Let :math:`d_1^M` be the result of computing :math:`\narrow^{\sx}_{M,N}(\lanes_{t_1\K{x}M}(c_1))`.

7. Let :math:`c` be the result of :math:`\lanes^{-1}_{t_2\K{x}N}(d_1^M~d_2^M)`.

8. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~t_2\K{x}N\K{.}\NARROW\_t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & d_1^M = \narrow^{\sx}_{M,N}( \lanes_{t_1\K{x}M}(c_1)) \\
     \wedge & d_2^M = \narrow^{\sx}_{M,N}( \lanes_{t_1\K{x}M}(c_2)) \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(d_1^M~d_2^M)
     \end{array}
   \end{array}


.. _exec-simd-widen:

:math:`t_2\K{x}N\K{.}\WIDEN\_\K{low}\_t_1\K{x}M\_\sx`
.....................................................

1. Assert: due to :ref:`validation <valid-vitestop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`i^\ast` be the sequence :math:`\lanes_{t_1\K{x}M}(c_1)[0 \slice N]`.

4. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(\extend^{\sx}_{t_1,t_2}(i^\ast))`

5. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\WIDEN\_\K{low}\_t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i^\ast = \lanes_{t_1\K{x}M}(c_1)[0 \slice N] \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(\extend^{\sx}_{M,N}(i^\ast))
     \end{array}
   \end{array}


:math:`t_2\K{x}N\K{.}\WIDEN\_\K{high}\_t_1\K{x}M\_\sx`
......................................................

1. Assert: due to :ref:`validation <valid-vitestop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

3. Let :math:`i^\ast` be the sequence :math:`\lanes_{t_1\K{x}M}(c_1)[N \slice N]`.

4. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(\extend^{\sx}_{t_1,t_2}(i^\ast))`

5. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\WIDEN\_\K{high}\_t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i^\ast = \lanes_{t_1\K{x}M}(c_1)[N \slice N] \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(\extend^{\sx}_{M,N}(i^\ast))
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

:math:`\SELECT`
...............

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
   \val_1~\val_2~(\I32\K{.}\CONST~c)~\SELECT &\stepto& \val_1
     & (\iff c \neq 0) \\
   \val_1~\val_2~(\I32\K{.}\CONST~c)~\SELECT &\stepto& \val_2
     & (\iff c = 0) \\
   \end{array}


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


.. index:: memory instruction, memory index, store, frame, address, memory address, memory instance, store, frame, value, integer, limits, value type, bit width
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

    b. Let :math:`c` be the result of computing :math:`\extend\F{\_}\sx_{N,|t|}(n)`.

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
     S; F; (t.\CONST~\extend\F{\_}\sx_{N,|t|}(n))
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


.. _exec-load-extend:

:math:`\V128\K{.}\LOAD{M}\K{x}N\_\sx~\memarg`
.............................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-load-extend>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-load-extend>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-load-extend>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`\X{ea} + M \cdot N /8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

10. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIDATA[\X{ea} \slice M \cdot N /8]`.

11. Let :math:`m_k` be the integer for which :math:`\bytes_{\iM}(m_k) = b^\ast[k \cdot M/8 \slice M/8]`.

12. Let :math:`W` be the integer :math:`M \cdot 2`.

13. Let :math:`n_k` be the result of :math:`\extend^{\sx}_{M,W}(m_k)`.

14. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\X{i}W\K{x}N}(n_0 \dots n_{N-1})`.

15. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\LOAD{M}\K{x}N\_\sx~\memarg) &\stepto&
     S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + M \cdot N / 8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA| \\
     \wedge & \bytes_{\iM}(m_k) = S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA[\X{ea} + k \cdot M/8 \slice M/8]) \\
     \wedge & W = M \cdot 2 \\
     \wedge & c = \lanes^{-1}_{\X{i}W\K{x}N}(\extend^{\sx}_{M,W}(m_0) \dots \extend^{\sx}_{M,W}(m_{N-1}))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~k)~(\V128.\LOAD{M}\K{x}N\K{\_}\sx~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}


.. _exec-load-splat:

:math:`\V128\K{.}\LOAD{N}\K{\_splat}~\memarg`
.............................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-load-extend>`, :math:`F.\AMODULE.\MIMEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[0]`.

4. Assert: due to :ref:`validation <valid-load-extend>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-load-extend>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIDATA`, then:

    a. Trap.

10. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIDATA[\X{ea} \slice N/8]`.

11. Let :math:`n` be the integer for which :math:`\bytes_{\iN}(n) = b^\ast`.

12. Let :math:`L` be the integer :math:`128 / N`.

13. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\iN\K{x}L}(n^L)`.

14. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128\K{.}\LOAD{N}\K{\_splat}~\memarg) &\stepto& S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA| \\
     \wedge & \bytes_{\iN}(n) = S.\SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA[\X{ea} \slice N/8]) \\
     \wedge & c = \lanes^{-1}_{\iN\K{x}L}(n^L)
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~k)~(\V128.\LOAD{N}\K{\_splat}~\memarg) &\stepto& S; F; \TRAP
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
     \wedge & S' = S \with \SMEMS[F.\AMODULE.\MIMEMS[0]].\MIDATA[\X{ea} \slice |t|/8] = \bytes_t(c)
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
   \begin{array}{lcl@{\qquad}l}
   F; \val^m~\BLOCK~\X{bt}~\instr^\ast~\END &\stepto&
     F; \LABEL_n\{\epsilon\}~\val^m~\instr^\ast~\END
     & (\iff \expand_F(\X{bt}) = [t_1^m] \to [t_2^n])
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
   \begin{array}{lcl@{\qquad}l}
   F; \val^m~\LOOP~\X{bt}~\instr^\ast~\END &\stepto&
     F; \LABEL_m\{\LOOP~\X{bt}~\instr^\ast~\END\}~\val^m~\instr^\ast~\END
     & (\iff \expand_F(\X{bt}) = [t_1^m] \to [t_2^n])
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
   \begin{array}{lcl@{\qquad}l}
   F; \val^m~(\I32.\CONST~c)~\IF~\X{bt}~\instr_1^\ast~\ELSE~\instr_2^\ast~\END &\stepto&
     F; \LABEL_n\{\epsilon\}~\val^m~\instr_1^\ast~\END
     & (\iff c \neq 0 \wedge \expand_F(\X{bt}) = [t_1^m] \to [t_2^n]) \\
   F; \val^m~(\I32.\CONST~c)~\IF~\X{bt}~\instr_1^\ast~\ELSE~\instr_2^\ast~\END &\stepto&
     F; \LABEL_n\{\epsilon\}~\val^m~\instr_2^\ast~\END
     & (\iff c = 0 \wedge \expand_F(\X{bt}) = [t_1^m] \to [t_2^n]) \\
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

:math:`\CALLINDIRECT~x`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITABLES[0]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[0]`.

4. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\STABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITYPES[x]` exists.

7. Let :math:`\X{ft}_{\F{expect}}` be the :ref:`function type <syntax-functype>` :math:`F.\AMODULE.\MITYPES[x]`.

8. Assert: due to :ref:`validation <valid-call_indirect>`, a value with :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIELEM`, then:

    a. Trap.

11. If :math:`\X{tab}.\TIELEM[i]` is uninitialized, then:

    a. Trap.

12. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`\X{tab}.\TIELEM[i]`.

13. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\SFUNCS[a]` exists.

14. Let :math:`\X{f}` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[a]`.

15. Let :math:`\X{ft}_{\F{actual}}` be the :ref:`function type <syntax-functype>` :math:`\X{f}.\FITYPE`.

16. If :math:`\X{ft}_{\F{actual}}` and :math:`\X{ft}_{\F{expect}}` differ, then:

    a. Trap.

17. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\CALLINDIRECT~x) &\stepto& S; F; (\INVOKE~a)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\STABLES[F.\AMODULE.\MITABLES[0]].\TIELEM[i] = a \\
     \wedge & S.\SFUNCS[a] = f \\
     \wedge & F.\AMODULE.\MITYPES[x] = f.\FITYPE)
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\CALLINDIRECT~x) &\stepto& S; F; \TRAP
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

When the end of a block is reached without a jump or trap aborting it, then the following steps are performed.

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

9. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~f.\FIMODULE, \ALOCALS~\val^n~\val_0^\ast \}`.

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
     \wedge & F = \{ \AMODULE~f.\FIMODULE, ~\ALOCALS~\val^n~(t.\CONST~0)^k \})
     \end{array} \\
   \end{array}


.. _exec-invoke-exit:

Returning from a function
.........................

When the end of a function is reached without a jump (i.e., |RETURN|) or trap aborting it, then the following steps are performed.

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
