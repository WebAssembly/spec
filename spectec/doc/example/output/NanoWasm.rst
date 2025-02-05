NanoWasm
========

*NanoWasm* is a small language with simple types and instructions.


Abstract Syntax
---------------

The *abstract syntax* of types is as follows:

.. math::
   \begin{array}[t]{@{}l@{}rrl@{}l@{}}
   & {\mathit{mut}} & ::= & \mathsf{mut} \\[0.8ex]
   & {\mathit{valtype}} & ::= & \mathsf{i{\scriptstyle 32}} ~|~ \mathsf{i{\scriptstyle 64}} ~|~ \mathsf{f{\scriptstyle 32}} ~|~ \mathsf{f{\scriptstyle 64}} \\[0.8ex]
   & {\mathit{functype}} & ::= & {{\mathit{valtype}}^\ast} \rightarrow {{\mathit{valtype}}^\ast} \\[0.8ex]
   & {\mathit{globaltype}} & ::= & {{\mathit{mut}}^?}~{\mathit{valtype}} \\
   \end{array}

Instructions take the following form:

.. _syntax-i32:

.. math::
   \begin{array}[t]{@{}l@{}rrl@{}l@{}}
   & {\mathit{const}} & ::= & 0 ~|~ 1 ~|~ 2 ~|~ \dots \\[0.8ex]
   & {\mathit{instr}} & ::= & \mathsf{nop} \\
   & & | & \mathsf{drop} \\
   & & | & \mathsf{select} \\
   & & | & {\mathit{valtype}}{.}\mathsf{const}~{\mathit{const}} \\
   & & | & \mathsf{local{.}get}~{\mathit{localidx}} \\
   & & | & \mathsf{local{.}set}~{\mathit{localidx}} \\
   & & | & \mathsf{global{.}get}~{\mathit{globalidx}} \\
   & & | & \mathsf{global{.}set}~{\mathit{globalidx}} \\
   \end{array}

The instruction :math:`\mathsf{nop}` does nothing,
:math:`\mathsf{drop}` removes an operand from the stack,
:math:`\mathsf{select}` picks one of two operands depending on a condition value.
The instruction :math:`t{.}\mathsf{const}~c` pushed the constant :math:`c` to the stack.
The remaining instructions access local and global variables.


Validation
----------

NanoWasm instructions are *type-checked* under a context that assigns types to indices:

.. math::
   \begin{array}[t]{@{}l@{}rrl@{}l@{}}
   & {\mathit{context}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
   \mathsf{globals}~{{\mathit{globaltype}}^\ast} ,  \mathsf{locals}~{{\mathit{valtype}}^\ast} \} \\
   \end{array} \\
   \end{array}

:math:`\mathsf{nop}`
...............................




:math:`\mathsf{nop}` is :ref:`valid <valid-val>` with :math:`\epsilon~\rightarrow~\epsilon`.


.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   C \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
   }
   \qquad
   \end{array}

:math:`\mathsf{drop}`
...............................




:math:`\mathsf{drop}` is :ref:`valid <valid-val>` with :math:`t~\rightarrow~\epsilon`.


.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   C \vdash \mathsf{drop} : t \rightarrow \epsilon
   }
   \qquad
   \end{array}

:math:`\mathsf{select}`
...............................




:math:`\mathsf{select}` is :ref:`valid <valid-val>` with :math:`t~t~\mathsf{i{\scriptstyle 32}}~\rightarrow~t`.


.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   C \vdash \mathsf{select} : t~t~\mathsf{i{\scriptstyle 32}} \rightarrow t
   }
   \qquad
   \end{array}

.. _valid-val:

:math:`\mathsf{const}`
...............................




:math:`(t{.}\mathsf{const}~c)` is :ref:`valid <valid-val>` with :math:`\epsilon~\rightarrow~t`.


.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   C \vdash t{.}\mathsf{const}~c : \epsilon \rightarrow t
   }
   \qquad
   \end{array}

:math:`\mathsf{local{.}get}`
...............................




:math:`(\mathsf{local{.}get}~x)` is :ref:`valid <valid-val>` with :math:`\epsilon~\rightarrow~t` if:


   * :math:`C{.}\mathsf{locals}{}[x]` exists.

   * :math:`C{.}\mathsf{locals}{}[x]` is equal to :math:`t`.


.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   C{.}\mathsf{locals}{}[x] = t
   }{
   C \vdash \mathsf{local{.}get}~x : \epsilon \rightarrow t
   }
   \qquad
   \end{array}

:math:`\mathsf{local{.}set}`
...............................




:math:`(\mathsf{local{.}set}~x)` is :ref:`valid <valid-val>` with :math:`t~\rightarrow~\epsilon` if:


   * :math:`C{.}\mathsf{locals}{}[x]` exists.

   * :math:`C{.}\mathsf{locals}{}[x]` is equal to :math:`t`.


.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   C{.}\mathsf{locals}{}[x] = t
   }{
   C \vdash \mathsf{local{.}set}~x : t \rightarrow \epsilon
   }
   \qquad
   \end{array}

:math:`\mathsf{global{.}get}`
...............................




:math:`(\mathsf{global{.}get}~x)` is :ref:`valid <valid-val>` with :math:`\epsilon~\rightarrow~t` if:


   * :math:`C{.}\mathsf{globals}{}[x]` exists.

   * :math:`C{.}\mathsf{globals}{}[x]` is equal to :math:`({\mathsf{mut}^?}~t)`.


.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   C{.}\mathsf{globals}{}[x] = {\mathsf{mut}^?}~t
   }{
   C \vdash \mathsf{global{.}get}~x : \epsilon \rightarrow t
   }
   \qquad
   \end{array}

:math:`\mathsf{global{.}set}`
...............................




:math:`(\mathsf{global{.}get}~x)` is :ref:`valid <valid-val>` with :math:`t~\rightarrow~\epsilon` if:


   * :math:`C{.}\mathsf{globals}{}[x]` exists.

   * :math:`C{.}\mathsf{globals}{}[x]` is equal to :math:`(\mathsf{mut}~t)`.


.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   C{.}\mathsf{globals}{}[x] = \mathsf{mut}~t
   }{
   C \vdash \mathsf{global{.}get}~x : t \rightarrow \epsilon
   }
   \qquad
   \end{array}


Execution
---------

NanoWasm execution requires a suitable definition of state and configuration:

.. math::
   \begin{array}[t]{@{}l@{}rrl@{}l@{}}
   & {\mathit{addr}} & ::= & 0 ~|~ 1 ~|~ 2 ~|~ \dots \\
   & {\mathit{moduleinst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
   \mathsf{globals}~{{\mathit{addr}}^\ast} \} \\
   \end{array} \\[0.8ex]
   & {\mathit{val}} & ::= & \mathsf{const}~{\mathit{valtype}}~{\mathit{const}} \\[0.8ex]
   & {\mathit{store}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
   \mathsf{globals}~{{\mathit{val}}^\ast} \} \\
   \end{array} \\
   & {\mathit{frame}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
   \mathsf{locals}~{{\mathit{val}}^\ast} ,  \mathsf{module}~{\mathit{moduleinst}} \} \\
   \end{array} \\
   & {\mathit{state}} & ::= & {\mathit{store}} ; {\mathit{frame}} \\
   & {\mathit{config}} & ::= & {\mathit{state}} ; {{\mathit{instr}}^\ast} \\
   \end{array}

We define the following auxiliary functions for accessing and updating the state:

.. math::
   \begin{array}[t]{@{}lcl@{}l@{}}
   {\mathrm{local}}((s ; f), x) & = & f{.}\mathsf{locals}{}[x] \\
   {\mathrm{global}}((s ; f), x) & = & s{.}\mathsf{globals}{}[f{.}\mathsf{module}{.}\mathsf{globals}{}[x]] \\[0.8ex]
   {\mathrm{update}}_{\mathit{local}}((s ; f), x, v) & = & s ; f{}[{.}\mathsf{locals}{}[x] = v] \\
   {\mathrm{update}}_{\mathit{global}}((s ; f), x, v) & = & s{}[{.}\mathsf{globals}{}[f{.}\mathsf{module}{.}\mathsf{globals}{}[x]] = v] ; f \\
   \end{array}

With that, execution is defined as follows:


:math:`\mathsf{nop}`
....................


1. Do nothing.


.. math::
   \begin{array}[t]{@{}l@{}rcl@{}l@{}}
   & \mathsf{nop} & \hookrightarrow & \epsilon \\
   \end{array}


:math:`\mathsf{drop}`
.....................


1. Assert: Due to validation, a value is on the top of the stack.

#. Pop the value :math:`{\mathit{val}}` from the stack.

#. Do nothing.


.. math::
   \begin{array}[t]{@{}l@{}rcl@{}l@{}}
   & {\mathit{val}}~\mathsf{drop} & \hookrightarrow & \epsilon \\
   \end{array}


:math:`\mathsf{select}`
.......................


1. Assert: Due to validation, a :ref:`value type <syntax-I32>` is on the top of the stack.

#. Pop the value :math:`(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)` from the stack.

#. Assert: Due to validation, a value is on the top of the stack.

#. Pop the value :math:`{\mathit{val}}_2` from the stack.

#. Assert: Due to validation, a value is on the top of the stack.

#. Pop the value :math:`{\mathit{val}}_1` from the stack.

#. If :math:`c \neq 0`, then:

   a. Push the value :math:`{\mathit{val}}_1` to the stack.

#. Else:

   a. Push the value :math:`{\mathit{val}}_2` to the stack.


.. math::
   \begin{array}[t]{@{}l@{}rcl@{}l@{}}
   & {\mathit{val}}_1~{\mathit{val}}_2~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~\mathsf{select} & \hookrightarrow & {\mathit{val}}_1 & \quad \mbox{if}~ c \neq 0 \\[0.8ex]
   & {\mathit{val}}_1~{\mathit{val}}_2~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~\mathsf{select} & \hookrightarrow & {\mathit{val}}_2 & \quad \mbox{otherwise} \\
   \end{array}


:math:`\mathsf{local{.}get}~x`
..............................


1. Let :math:`z` be the current state.

#. Let :math:`{\mathit{val}}` be :math:`{\mathrm{local}}(z, x)`.

#. Push the value :math:`{\mathit{val}}` to the stack.


.. math::
   \begin{array}[t]{@{}l@{}rcl@{}l@{}}
   & z ; (\mathsf{local{.}get}~x) & \hookrightarrow & z ; {\mathit{val}} & \quad \mbox{if}~ {\mathit{val}} = {\mathrm{local}}(z, x) \\
   \end{array}


:math:`\mathsf{local{.}set}~x`
..............................


1. Assert: Due to validation, a value is on the top of the stack.

#. Pop the value :math:`{\mathit{val}}` from the stack.

#. Do nothing.


.. math::
   \begin{array}[t]{@{}l@{}rcl@{}l@{}}
   & z ; {\mathit{val}}~(\mathsf{local{.}set}~x) & \hookrightarrow & {z'} ; \epsilon & \quad \mbox{if}~ {z'} = {\mathrm{update}}_{\mathit{local}}(z, x, {\mathit{val}}) \\
   \end{array}


:math:`\mathsf{global{.}get}~x`
...............................


1. Let :math:`z` be the current state.

#. Let :math:`{\mathit{val}}` be :math:`{\mathrm{global}}(z, x)`.

#. Push the value :math:`{\mathit{val}}` to the stack.


.. math::
   \begin{array}[t]{@{}l@{}rcl@{}l@{}}
   & z ; (\mathsf{global{.}get}~x) & \hookrightarrow & z ; {\mathit{val}} & \quad \mbox{if}~ {\mathit{val}} = {\mathrm{global}}(z, x) \\
   \end{array}


:math:`\mathsf{global{.}set}~x`
...............................


1. Assert: Due to validation, a value is on the top of the stack.

#. Pop the value :math:`{\mathit{val}}` from the stack.

#. Do nothing.


.. math::
   \begin{array}[t]{@{}l@{}rcl@{}l@{}}
   & z ; {\mathit{val}}~(\mathsf{global{.}set}~x) & \hookrightarrow & {z'} ; \epsilon & \quad \mbox{if}~ {z'} = {\mathrm{update}}_{\mathit{global}}(z, x, {\mathit{val}}) \\
   \end{array}


Binary Format
-------------

The following grammars define the binary representation of NanoWasm programs.

First, constants are represented in LEB format:

.. math::
   \begin{array}[t]{@{}l@{}rrl@{}l@{}l@{}l@{}}
   & {\mathtt{byte}} & ::= & b{:}\mathtt{0x00} ~|~ \ldots ~|~ b{:}\mathtt{0xFF} & \quad\Rightarrow\quad{} & b \\[0.8ex]
   & {\mathtt{u}}(N) & ::= & n{:}{\mathtt{byte}} & \quad\Rightarrow\quad{} & n & \quad \mbox{if}~ n < {2^{7}} \land n < {2^{N}} \\
   & & | & n{:}{\mathtt{byte}}~~m{:}{\mathtt{u}}(N - 7) & \quad\Rightarrow\quad{} & {2^{7}} \cdot m + (n - {2^{7}}) & \quad \mbox{if}~ n \geq {2^{7}} \land N > 7 \\[0.8ex]
   & {\mathtt{u32}} & ::= & n{:}{\mathtt{u}}(32) & \quad\Rightarrow\quad{} & n \\
   & {\mathtt{u64}} & ::= & n{:}{\mathtt{u}}(64) & \quad\Rightarrow\quad{} & n \\[0.8ex]
   & {\mathtt{f}}(N) & ::= & {b^\ast}{:}{{\mathtt{byte}}^{N / 8}} & \quad\Rightarrow\quad{} & {\mathrm{float}}(N, {b^\ast}) \\[0.8ex]
   & {\mathtt{f32}} & ::= & p{:}{\mathtt{f}}(32) & \quad\Rightarrow\quad{} & p \\
   & {\mathtt{f64}} & ::= & p{:}{\mathtt{f}}(64) & \quad\Rightarrow\quad{} & p \\
   \end{array}

Types are encoded as follows:

.. math::
   \begin{array}[t]{@{}l@{}rrl@{}l@{}l@{}l@{}}
   & {\mathtt{valtype}} & ::= & \mathtt{0x7F} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} \\
   & & | & \mathtt{0x7E} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} \\
   & & | & \mathtt{0x7D} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} \\
   & & | & \mathtt{0x7C} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} \\[0.8ex]
   & {\mathtt{mut}} & ::= & \mathtt{0x00} & \quad\Rightarrow\quad{} & \epsilon \\
   & & | & \mathtt{0x01} & \quad\Rightarrow\quad{} & \mathsf{mut} \\[0.8ex]
   & {\mathtt{globaltype}} & ::= & t{:}{\mathtt{valtype}}~~{\mathit{mut}}{:}{\mathtt{mut}} & \quad\Rightarrow\quad{} & {\mathit{mut}}~t \\
   & {\mathtt{resulttype}} & ::= & n{:}{\mathtt{u32}}~~{(t{:}{\mathtt{valtype}})^{n}} & \quad\Rightarrow\quad{} & {t^{n}} \\
   & {\mathtt{functype}} & ::= & \mathtt{0x60}~~{t_1^\ast}{:}{\mathtt{resulttype}}~~{t_2^\ast}{:}{\mathtt{resulttype}} & \quad\Rightarrow\quad{} & {t_1^\ast} \rightarrow {t_2^\ast} \\
   \end{array}

Finally, instruction opcodes:

.. math::
   \begin{array}[t]{@{}l@{}rrl@{}l@{}l@{}l@{}}
   & {\mathtt{globalidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
   & {\mathtt{localidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\[0.8ex]
   & {\mathtt{instr}} & ::= & \mathtt{0x01} & \quad\Rightarrow\quad{} & \mathsf{nop} \\
   & & | & \mathtt{0x1A} & \quad\Rightarrow\quad{} & \mathsf{drop} \\
   & & | & \mathtt{0x1B} & \quad\Rightarrow\quad{} & \mathsf{select} \\
   & & | & \mathtt{0x20}~~x{:}{\mathtt{localidx}} & \quad\Rightarrow\quad{} & \mathsf{local{.}get}~x \\
   & & | & \mathtt{0x21}~~x{:}{\mathtt{localidx}} & \quad\Rightarrow\quad{} & \mathsf{local{.}set}~x \\
   & & | & \mathtt{0x23}~~x{:}{\mathtt{globalidx}} & \quad\Rightarrow\quad{} & \mathsf{global{.}get}~x \\
   & & | & \mathtt{0x24}~~x{:}{\mathtt{globalidx}} & \quad\Rightarrow\quad{} & \mathsf{global{.}set}~x \\
   & & | & \mathtt{0x41}~~n{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n \\
   & & | & \mathtt{0x42}~~n{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}}{.}\mathsf{const}~n \\
   & & | & \mathtt{0x43}~~p{:}{\mathtt{f32}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}}{.}\mathsf{const}~p \\
   & & | & \mathtt{0x44}~~p{:}{\mathtt{f64}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~p \\
   \end{array}
