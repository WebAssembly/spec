.. _exec-instructions:

Instructions
------------

.. _exec-instructions-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-UNOP:


:math:`\UNOP-instr-numeric~nt~unop`
...................................


1. Assert: Due to :ref:`validation <valid-UNOP>`, a value of value type :math:`nt` is on the top of the stack.

2. Pop :math:`nt.\CONST-instr-numeric~c_{1}` from the stack.

3. If the length of :math:`\unop-(unop, nt, c_{1})` is :math:`1`, then:

   a. Let :math:`c` be :math:`\unop-(unop, nt, c_{1})`.

   b. Push :math:`nt.\CONST-instr-numeric~c` to the stack.

4. If :math:`\unop-(unop, nt, c_{1})` is :math:`\epsilon`, then:

   a. Trap.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}unop{-}val}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt} . \mathit{unop}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~\mathit{c}) &\quad
     \mbox{if}~{{{\mathit{unop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1})} = \mathit{c} \\[0.8ex]
   {[\textsc{\scriptsize E{-}unop{-}trap}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt} . \mathit{unop}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~{{{\mathit{unop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1})} = \epsilon \\
   \end{array}

.. _exec-BINOP:


:math:`\BINOP-instr-numeric~nt~binop`
.....................................


1. Assert: Due to :ref:`validation <valid-BINOP>`, a value of value type :math:`nt` is on the top of the stack.

2. Pop :math:`nt.\CONST-instr-numeric~c_{2}` from the stack.

3. Assert: Due to :ref:`validation <valid-BINOP>`, a value of value type :math:`nt` is on the top of the stack.

4. Pop :math:`nt.\CONST-instr-numeric~c_{1}` from the stack.

5. If the length of :math:`\binop-(binop, nt, c_{1}, c_{2})` is :math:`1`, then:

   a. Let :math:`c` be :math:`\binop-(binop, nt, c_{1}, c_{2})`.

   b. Push :math:`nt.\CONST-instr-numeric~c` to the stack.

6. If :math:`\binop-(binop, nt, c_{1}, c_{2})` is :math:`\epsilon`, then:

   a. Trap.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}binop{-}val}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}.\mathsf{const}~\mathit{c}_{2})~(\mathit{nt} . \mathit{binop}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~\mathit{c}) &\quad
     \mbox{if}~{{{\mathit{binop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1},\, \mathit{c}_{2})} = \mathit{c} \\[0.8ex]
   {[\textsc{\scriptsize E{-}binop{-}trap}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}.\mathsf{const}~\mathit{c}_{2})~(\mathit{nt} . \mathit{binop}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~{{{\mathit{binop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1},\, \mathit{c}_{2})} = \epsilon \\
   \end{array}

.. _exec-TESTOP:


:math:`\TESTOP-instr-numeric~nt~testop`
.......................................


1. Assert: Due to :ref:`validation <valid-TESTOP>`, a value of value type :math:`nt` is on the top of the stack.

2. Pop :math:`nt.\CONST-instr-numeric~c_{1}` from the stack.

3. Let :math:`c` be :math:`\testop-(testop, nt, c_{1})`.

4. Push :math:`\I32-numtype.\CONST-instr-numeric~c` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}testop}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt} . \mathit{testop}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c}) &\quad
     \mbox{if}~\mathit{c} = {{{\mathit{testop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1})} \\
   \end{array}

.. _exec-RELOP:


:math:`\RELOP-instr-numeric~nt~relop`
.....................................


1. Assert: Due to :ref:`validation <valid-RELOP>`, a value of value type :math:`nt` is on the top of the stack.

2. Pop :math:`nt.\CONST-instr-numeric~c_{2}` from the stack.

3. Assert: Due to :ref:`validation <valid-RELOP>`, a value of value type :math:`nt` is on the top of the stack.

4. Pop :math:`nt.\CONST-instr-numeric~c_{1}` from the stack.

5. Let :math:`c` be :math:`\relop-(relop, nt, c_{1}, c_{2})`.

6. Push :math:`\I32-numtype.\CONST-instr-numeric~c` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}relop}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}.\mathsf{const}~\mathit{c}_{2})~(\mathit{nt} . \mathit{relop}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c}) &\quad
     \mbox{if}~\mathit{c} = {{{\mathit{relop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1},\, \mathit{c}_{2})} \\
   \end{array}

.. _exec-CVTOP:


:math:`\CVTOP-instr-numeric~nt_{2}~cvtop~nt_{1}~{sx}{^?}`
.........................................................


1. Assert: Due to validation, a value of value type :math:`nt_{1}` is on the top of the stack.

2. Pop :math:`nt_{1}.\CONST-instr-numeric~c_{1}` from the stack.

3. If the length of :math:`\cvtop-(nt_{1}, cvtop, nt_{2}, {sx}{^?}, c_{1})` is :math:`1`, then:

   a. Let :math:`c` be :math:`\cvtop-(nt_{1}, cvtop, nt_{2}, {sx}{^?}, c_{1})`.

   b. Push :math:`nt_{2}.\CONST-instr-numeric~c` to the stack.

4. If :math:`\cvtop-(nt_{1}, cvtop, nt_{2}, {sx}{^?}, c_{1})` is :math:`\epsilon`, then:

   a. Trap.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}cvtop{-}val}]} \quad & (\mathit{nt}_{1}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}_{2} . {{{{\mathit{cvtop}}{\mathsf{\_}}}{\mathit{nt}_{1}}}{\mathsf{\_}}}{{\mathit{sx}^?}}) &\hookrightarrow& (\mathit{nt}_{2}.\mathsf{const}~\mathit{c}) &\quad
     \mbox{if}~\mathrm{cvtop}(\mathit{nt}_{1},\, \mathit{cvtop},\, \mathit{nt}_{2},\, {\mathit{sx}^?},\, \mathit{c}_{1}) = \mathit{c} \\[0.8ex]
   {[\textsc{\scriptsize E{-}cvtop{-}trap}]} \quad & (\mathit{nt}_{1}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}_{2} . {{{{\mathit{cvtop}}{\mathsf{\_}}}{\mathit{nt}_{1}}}{\mathsf{\_}}}{{\mathit{sx}^?}}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathrm{cvtop}(\mathit{nt}_{1},\, \mathit{cvtop},\, \mathit{nt}_{2},\, {\mathit{sx}^?},\, \mathit{c}_{1}) = \epsilon \\
   \end{array}

.. _exec-instructions-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-REF.IS_NULL:


:math:`\REFISNULL-instr-reference`
..................................


1. Assert: Due to :ref:`validation <valid-REF.IS_NULL>`, a value is on the top of the stack.

2. Pop :math:`val` from the stack.

3. If :math:`val` is not of the case :math:`\REFNULL-ref`, then:

   a. Push :math:`\I32-numtype.\CONST-instr-numeric~0` to the stack.

4. Else:

   a. Push :math:`\I32-numtype.\CONST-instr-numeric~1` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}ref.is\_null{-}true}]} \quad & \mathit{val}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
     \mbox{if}~\mathit{val} = (\mathsf{ref.null}~\mathit{rt}) \\[0.8ex]
   {[\textsc{\scriptsize E{-}ref.is\_null{-}false}]} \quad & \mathit{val}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _exec-REF.FUNC:


:math:`\REFFUNC-instr-reference~x`
..................................


1. If :math:`x` is less than the length of :math:`\funcaddr-()`, then:

   a. Push :math:`\REFFUNCADDR-admininstr~\funcaddr-()[x]` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}ref.func}]} \quad & \mathit{z} ; (\mathsf{ref.func}~\mathit{x}) &\hookrightarrow& (\mathsf{ref.func}~\mathit{z}.\mathsf{module}.\mathsf{func}[\mathit{x}]) &  \\
   \end{array}

.. _exec-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-DROP:


:math:`\DROP-instr-control`
...........................


1. Assert: Due to :ref:`validation <valid-DROP>`, a value is on the top of the stack.

2. Pop :math:`val` from the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}drop}]} \quad & \mathit{val}~\mathsf{drop} &\hookrightarrow& \epsilon &  \\
   \end{array}

.. _exec-SELECT:


:math:`\SELECT-instr-control~{t}{^?}`
.....................................


1. Assert: Due to :ref:`validation <valid-SELECT>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~c` from the stack.

3. Assert: Due to :ref:`validation <valid-SELECT>`, a value is on the top of the stack.

4. Pop :math:`val_{2}` from the stack.

5. Assert: Due to :ref:`validation <valid-SELECT>`, a value is on the top of the stack.

6. Pop :math:`val_{1}` from the stack.

7. If :math:`c` is not :math:`0`, then:

   a. Push :math:`val_{1}` to the stack.

8. Else:

   a. Push :math:`val_{2}` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}select{-}true}]} \quad & \mathit{val}_{1}~\mathit{val}_{2}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{select}~{\mathit{t}^?}) &\hookrightarrow& \mathit{val}_{1} &\quad
     \mbox{if}~\mathit{c} \neq 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}select{-}false}]} \quad & \mathit{val}_{1}~\mathit{val}_{2}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{select}~{\mathit{t}^?}) &\hookrightarrow& \mathit{val}_{2} &\quad
     \mbox{if}~\mathit{c} = 0 \\
   \end{array}

.. _exec-INSTRUCTIONS-VARIABLE:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:


:math:`\LOCALGET-instr-state~x`
...............................


1. Push :math:`\local-(x)` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}local.get}]} \quad & \mathit{z} ; (\mathsf{local.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{local}}{[\mathit{x}]} &  \\
   \end{array}

.. _exec-local.set:


:math:`\LOCALSET-instr-state~x`
...............................


1. Assert: Due to :ref:`validation <valid-LOCAL.SET>`, a value is on the top of the stack.

2. Pop :math:`val` from the stack.

3. Perform :math:`\withlocal-(x, val)`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}local.set}]} \quad & \mathit{z} ; \mathit{val}~(\mathsf{local.set}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{local}[\mathit{x}] = \mathit{val}] ; \epsilon &  \\
   \end{array}

.. _exec-local.tee:


:math:`\LOCALTEE-instr-state~x`
...............................


1. Assert: Due to :ref:`validation <valid-LOCAL.TEE>`, a value is on the top of the stack.

2. Pop :math:`val` from the stack.

3. Push :math:`val` to the stack.

4. Push :math:`val` to the stack.

5. Execute :math:`\LOCALSET-instr-state~x`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}local.tee}]} \quad & \mathit{val}~(\mathsf{local.tee}~\mathit{x}) &\hookrightarrow& \mathit{val}~\mathit{val}~(\mathsf{local.set}~\mathit{x}) &  \\
   \end{array}

.. _exec-global.get:


:math:`\GLOBALGET-instr-state~x`
................................


1. Push :math:`\global-(x).\VALUE-globalinst` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}global.get}]} \quad & \mathit{z} ; (\mathsf{global.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{global}}{[\mathit{x}]}.\mathsf{value} &  \\
   \end{array}

.. _exec-global.set:


:math:`\GLOBALSET-instr-state~x`
................................


1. Assert: Due to :ref:`validation <valid-GLOBAL.SET>`, a value is on the top of the stack.

2. Pop :math:`val` from the stack.

3. Perform :math:`\withglobal-(x, val)`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}global.set}]} \quad & \mathit{z} ; \mathit{val}~(\mathsf{global.set}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{global}[\mathit{x}].\mathsf{value} = \mathit{val}] ; \epsilon &  \\
   \end{array}

.. _exec-instructions-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-TABLE.GET:


:math:`\TABLEGET-instr-state~x`
...............................


1. Assert: Due to :ref:`validation <valid-TABLE.GET>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

3. If :math:`i` is greater than or equal to the length of :math:`\table-(x).\ELEM-tableinst`, then:

   a. Trap.

4. Push :math:`\table-(x).\ELEM-tableinst[i]` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}table.get{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{x}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} \geq {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.get{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}[\mathit{i}] &\quad
     \mbox{if}~\mathit{i} < {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
   \end{array}

.. _exec-TABLE.SET:


:math:`\TABLESET-instr-state~x`
...............................


1. Assert: Due to :ref:`validation <valid-TABLE.SET>`, a value is on the top of the stack.

2. Pop :math:`ref` from the stack.

3. Assert: Due to :ref:`validation <valid-TABLE.SET>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

4. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

5. If :math:`i` is greater than or equal to the length of :math:`\table-(x).\ELEM-tableinst`, then:

   a. Trap.

6. Perform :math:`\withtable-(x, i, ref)`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}table.set{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{ref}~(\mathsf{table.set}~\mathit{x}) &\hookrightarrow& \mathit{z} ; \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} \geq {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.set{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{ref}~(\mathsf{table.set}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{table}[\mathit{x}].\mathsf{elem}[\mathit{i}] = \mathit{ref}] ; \epsilon &\quad
     \mbox{if}~\mathit{i} < {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
   \end{array}

.. _exec-TABLE.SIZE:


:math:`\TABLESIZE-instr-state~x`
................................


1. Let :math:`n` be the length of :math:`\table-(x).\ELEM-tableinst`.

2. Push :math:`\I32-numtype.\CONST-instr-numeric~n` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}table.size}]} \quad & \mathit{z} ; (\mathsf{table.size}~\mathit{x}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n}) &\quad
     \mbox{if}~{|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} = \mathit{n} \\
   \end{array}

.. _exec-TABLE.GROW:


:math:`\TABLEGROW-instr-state~x`
................................


1. Assert: Due to :ref:`validation <valid-TABLE.GROW>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~n` from the stack.

3. Assert: Due to :ref:`validation <valid-TABLE.GROW>`, a value is on the top of the stack.

4. Pop :math:`ref` from the stack.

5. Either:

   a. Let :math:`ti` be :math:`\growtable-(\table-(x), n, ref)`.

   b. Push :math:`\I32-numtype.\CONST-instr-numeric~|\table-(x).\ELEM-tableinst|` to the stack.

   c. Perform :math:`\withtableinst-(x, ti)`.

6. Or:

   a. Push :math:`\I32-numtype.\CONST-instr-numeric~-1` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}table.grow{-}succeed}]} \quad & \mathit{z} ; \mathit{ref}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.grow}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{table}[\mathit{x}] = \mathit{ti}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|}) &\quad
     \mbox{if}~\mathrm{grow}_{\mathit{table}}({\mathit{z}.\mathsf{table}}{[\mathit{x}]},\, \mathit{n},\, \mathit{ref}) = \mathit{ti} \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.grow{-}fail}]} \quad & \mathit{z} ; \mathit{ref}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.grow}~\mathit{x}) &\hookrightarrow& \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~-1) &  \\
   \end{array}

.. _exec-TABLE.FILL:


:math:`\TABLEFILL-instr-state~x`
................................


1. Assert: Due to :ref:`validation <valid-TABLE.FILL>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~n` from the stack.

3. Assert: Due to :ref:`validation <valid-TABLE.FILL>`, a value is on the top of the stack.

4. Pop :math:`val` from the stack.

5. Assert: Due to :ref:`validation <valid-TABLE.FILL>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

6. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

7. If :math:`{i} + {n}` is greater than the length of :math:`\table-(x).\ELEM-tableinst`, then:

   a. Trap.

8. If :math:`n` is :math:`0`, then:

   a. Do nothing.

9. Else:

   a. Push :math:`\I32-numtype.\CONST-instr-numeric~i` to the stack.

   b. Push :math:`val` to the stack.

   c. Execute :math:`\TABLESET-instr-state~x`.

   d. Push :math:`\I32-numtype.\CONST-instr-numeric~{i} + {1}` to the stack.

   e. Push :math:`val` to the stack.

   f. Push :math:`\I32-numtype.\CONST-instr-numeric~{n} - {1}` to the stack.

   g. Execute :math:`\TABLEFILL-instr-state~x`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}table.fill{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.fill{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& \epsilon &\quad
     \mbox{otherwise, if}~\mathit{n} = 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.fill{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{table.fill}~\mathit{x}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _exec-TABLE.COPY:


:math:`\TABLECOPY-instr-state~x~y`
..................................


1. Assert: Due to :ref:`validation <valid-TABLE.COPY>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~n` from the stack.

3. Assert: Due to :ref:`validation <valid-TABLE.COPY>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

4. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

5. Assert: Due to :ref:`validation <valid-TABLE.COPY>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

6. Pop :math:`\I32-numtype.\CONST-instr-numeric~j` from the stack.

7. If :math:`{i} + {n}` is greater than the length of :math:`\table-(y).\ELEM-tableinst` or :math:`{j} + {n}` is greater than the length of :math:`\table-(x).\ELEM-tableinst`, then:

   a. Trap.

8. If :math:`n` is :math:`0`, then:

   a. Do nothing.

9. Else:

   a. If :math:`j` is less than or equal to :math:`i`, then:

      1) Push :math:`\I32-numtype.\CONST-instr-numeric~j` to the stack.

      2) Push :math:`\I32-numtype.\CONST-instr-numeric~i` to the stack.

      3) Execute :math:`\TABLEGET-instr-state~y`.

      4) Execute :math:`\TABLESET-instr-state~x`.

      5) Push :math:`\I32-numtype.\CONST-instr-numeric~{j} + {1}` to the stack.

      6) Push :math:`\I32-numtype.\CONST-instr-numeric~{i} + {1}` to the stack.

   b. Else:

      1) Push :math:`\I32-numtype.\CONST-instr-numeric~{{j} + {n}} - {1}` to the stack.

      2) Push :math:`\I32-numtype.\CONST-instr-numeric~{{i} + {n}} - {1}` to the stack.

      3) Execute :math:`\TABLEGET-instr-state~y`.

      4) Execute :math:`\TABLESET-instr-state~x`.

      5) Push :math:`\I32-numtype.\CONST-instr-numeric~j` to the stack.

      6) Push :math:`\I32-numtype.\CONST-instr-numeric~i` to the stack.

   c. Push :math:`\I32-numtype.\CONST-instr-numeric~{n} - {1}` to the stack.

   d. Execute :math:`\TABLECOPY-instr-state~x~y`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}table.copy{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{y}]}.\mathsf{elem}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.copy{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& \epsilon &\quad
     \mbox{otherwise, if}~\mathit{n} = 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.copy{-}le}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{y})~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\quad
     \mbox{otherwise, if}~\mathit{j} \leq \mathit{i} \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.copy{-}gt}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + \mathit{n} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + \mathit{n} - 1)~(\mathsf{table.get}~\mathit{y})~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _exec-TABLE.INIT:


:math:`\TABLEINIT-instr-state~x~y`
..................................


1. Assert: Due to :ref:`validation <valid-TABLE.INIT>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~n` from the stack.

3. Assert: Due to :ref:`validation <valid-TABLE.INIT>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

4. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

5. Assert: Due to :ref:`validation <valid-TABLE.INIT>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

6. Pop :math:`\I32-numtype.\CONST-instr-numeric~j` from the stack.

7. If :math:`{i} + {n}` is greater than the length of :math:`\elem-(y).\ELEM-eleminst` or :math:`{j} + {n}` is greater than the length of :math:`\table-(x).\ELEM-tableinst`, then:

   a. Trap.

8. If :math:`n` is :math:`0`, then:

   a. Do nothing.

9. Else if :math:`i` is less than the length of :math:`\elem-(y).\ELEM-eleminst`, then:

   a. Push :math:`\I32-numtype.\CONST-instr-numeric~j` to the stack.

   b. Push :math:`\elem-(y).\ELEM-eleminst[i]` to the stack.

   c. Execute :math:`\TABLESET-instr-state~x`.

   d. Push :math:`\I32-numtype.\CONST-instr-numeric~{j} + {1}` to the stack.

   e. Push :math:`\I32-numtype.\CONST-instr-numeric~{i} + {1}` to the stack.

   f. Push :math:`\I32-numtype.\CONST-instr-numeric~{n} - {1}` to the stack.

   g. Execute :math:`\TABLEINIT-instr-state~x~y`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}table.init{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{elem}}{[\mathit{y}]}.\mathsf{elem}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.init{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& \epsilon &\quad
     \mbox{otherwise, if}~\mathit{n} = 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}table.init{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~{\mathit{z}.\mathsf{elem}}{[\mathit{y}]}.\mathsf{elem}[\mathit{i}]~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _exec-ELEM.DROP:


:math:`\ELEMDROP-instr-state~x`
...............................


1. Perform :math:`\withelem-(x, \epsilon)`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}elem.drop}]} \quad & \mathit{z} ; (\mathsf{elem.drop}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{elem}[\mathit{x}].\mathsf{elem} = \epsilon] ; \epsilon &  \\
   \end{array}

.. _exec-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-LOAD:


:math:`\LOAD-instr-state~nt~{x_{0}}{^?}~n_{A}~n_{O}`
....................................................


1. Assert: Due to :ref:`validation <valid-LOAD>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

3. If :math:`{x_{0}}{^?}` is not defined, then:

   a. If :math:`{{i} + {n_{O}}} + {{\size-(nt)} / {8}}` is greater than the length of :math:`\mem-(0).\DATA-meminst`, then:

      1) Trap.

   b. Let :math:`c` be :math:`inverse\_of\_bytes(\size-(nt), \mem-(0).\DATA-meminst[{i} + {n_{O}} : {\size-(nt)} / {8}])`.

   c. Push :math:`nt.\CONST-instr-numeric~c` to the stack.

4. Else:

   a. Let :math:`{y_{0}}^?` be :math:`{x_{0}}{^?}`.

   b. Let :math:`n~sx` be :math:`y_{0}`.

   c. If :math:`{{i} + {n_{O}}} + {{n} / {8}}` is greater than the length of :math:`\mem-(0).\DATA-meminst`, then:

      1) Trap.

   d. Let :math:`c` be :math:`inverse\_of\_bytes(n, \mem-(0).\DATA-meminst[{i} + {n_{O}} : {n} / {8}])`.

   e. Push :math:`nt.\CONST-instr-numeric~\ext-(n, \size-(nt), sx, c)` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}load{-}num{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{load}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n}_{\mathsf{o}} + {|\mathit{nt}|} / 8 > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}load{-}num{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{load}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~\mathit{c}) &\quad
     \mbox{if}~{\mathrm{bytes}}_{{|\mathit{nt}|}}(\mathit{c}) = {\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}[\mathit{i} + \mathit{n}_{\mathsf{o}} : {|\mathit{nt}|} / 8] \\[0.8ex]
   {[\textsc{\scriptsize E{-}load{-}pack{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~({\mathit{nt}.\mathsf{load}}{{{\mathit{n}}{\mathsf{\_}}}{\mathit{sx}}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n}_{\mathsf{o}} + \mathit{n} / 8 > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}load{-}pack{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~({\mathit{nt}.\mathsf{load}}{{{\mathit{n}}{\mathsf{\_}}}{\mathit{sx}}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~{{\mathrm{ext}}_{\mathit{n}}({|\mathit{nt}|})^{\mathit{sx}}}~(\mathit{c})) &\quad
     \mbox{if}~{\mathrm{bytes}}_{\mathit{n}}(\mathit{c}) = {\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}[\mathit{i} + \mathit{n}_{\mathsf{o}} : \mathit{n} / 8] \\
   \end{array}

.. _exec-STORE:


:math:`\STORE-instr-state~nt~{x_{0}}{^?}~n_{A}~n_{O}`
.....................................................


1. Assert: Due to :ref:`validation <valid-STORE>`, a value of value type :math:`nt` is on the top of the stack.

2. Pop :math:`nt.\CONST-instr-numeric~c` from the stack.

3. Assert: Due to :ref:`validation <valid-STORE>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

4. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

5. If :math:`{x_{0}}{^?}` is not defined, then:

   a. If :math:`{{i} + {n_{O}}} + {{\size-(nt)} / {8}}` is greater than the length of :math:`\mem-(0).\DATA-meminst`, then:

      1) Trap.

   b. Let :math:`{b}{^\ast}` be :math:`\bytes-(\size-(nt), c)`.

   c. Perform :math:`\withmem-(0, {i} + {n_{O}}, {\size-(nt)} / {8}, {b}{^\ast})`.

6. Else:

   a. Let :math:`{n}^?` be :math:`{x_{0}}{^?}`.

   b. If :math:`{{i} + {n_{O}}} + {{n} / {8}}` is greater than the length of :math:`\mem-(0).\DATA-meminst`, then:

      1) Trap.

   c. Let :math:`{b}{^\ast}` be :math:`\bytes-(n, \wrap-(\size-(nt)~n, c))`.

   d. Perform :math:`\withmem-(0, {i} + {n_{O}}, {n} / {8}, {b}{^\ast})`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}store{-}num{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{const}~\mathit{c})~(\mathit{nt}.\mathsf{store}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathit{z} ; \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n}_{\mathsf{o}} + {|\mathit{nt}|} / 8 > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}store{-}num{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{const}~\mathit{c})~(\mathit{nt}.\mathsf{store}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathit{z}[\mathsf{mem}[0].\mathsf{data}[\mathit{i} + \mathit{n}_{\mathsf{o}} : {|\mathit{nt}|} / 8] = {\mathit{b}^\ast}] ; \epsilon &\quad
     \mbox{if}~{\mathit{b}^\ast} = {\mathrm{bytes}}_{{|\mathit{nt}|}}(\mathit{c}) \\[0.8ex]
   {[\textsc{\scriptsize E{-}store{-}pack{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{const}~\mathit{c})~({\mathit{nt}.\mathsf{store}}{\mathit{n}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathit{z} ; \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n}_{\mathsf{o}} + \mathit{n} / 8 > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}store{-}pack{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{const}~\mathit{c})~({\mathit{nt}.\mathsf{store}}{\mathit{n}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathit{z}[\mathsf{mem}[0].\mathsf{data}[\mathit{i} + \mathit{n}_{\mathsf{o}} : \mathit{n} / 8] = {\mathit{b}^\ast}] ; \epsilon &\quad
     \mbox{if}~{\mathit{b}^\ast} = {\mathrm{bytes}}_{\mathit{n}}({\mathrm{wrap}}_{{|\mathit{nt}|},\mathit{n}}(\mathit{c})) \\
   \end{array}

.. _exec-MEMORY.SIZE:


:math:`\MEMORYSIZE-instr-state`
...............................


1. Let :math:`{{n} \cdot {64}} \cdot {\Ki-()}` be the length of :math:`\mem-(0).\DATA-meminst`.

2. Push :math:`\I32-numtype.\CONST-instr-numeric~n` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}memory.size}]} \quad & \mathit{z} ; (\mathsf{memory.size}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n}) &\quad
     \mbox{if}~\mathit{n} \cdot 64 \cdot \mathrm{Ki} = {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
   \end{array}

.. _exec-MEMORY.GROW:


:math:`\MEMORYGROW-instr-state`
...............................


1. Assert: Due to :ref:`validation <valid-MEMORY.GROW>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~n` from the stack.

3. Either:

   a. Let :math:`mi` be :math:`\growmemory-(\mem-(0), n)`.

   b. Push :math:`\I32-numtype.\CONST-instr-numeric~{|\mem-(0).\DATA-meminst|} / {{64} \cdot {\Ki-()}}` to the stack.

   c. Perform :math:`\withmeminst-(0, mi)`.

4. Or:

   a. Push :math:`\I32-numtype.\CONST-instr-numeric~-1` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}memory.grow{-}succeed}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.grow}) &\hookrightarrow& \mathit{z}[\mathsf{mem}[0] = \mathit{mi}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} / (64 \cdot \mathrm{Ki})) &\quad
     \mbox{if}~\mathrm{grow}_{\mathit{memory}}({\mathit{z}.\mathsf{mem}}{[0]},\, \mathit{n}) = \mathit{mi} \\[0.8ex]
   {[\textsc{\scriptsize E{-}memory.grow{-}fail}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.grow}) &\hookrightarrow& \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~-1) &  \\
   \end{array}

.. _exec-MEMORY.FILL:


:math:`\MEMORYFILL-instr-state`
...............................


1. Assert: Due to :ref:`validation <valid-MEMORY.FILL>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~n` from the stack.

3. Assert: Due to :ref:`validation <valid-MEMORY.FILL>`, a value is on the top of the stack.

4. Pop :math:`val` from the stack.

5. Assert: Due to :ref:`validation <valid-MEMORY.FILL>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

6. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

7. If :math:`{i} + {n}` is greater than the length of :math:`\mem-(0).\DATA-meminst`, then:

   a. Trap.

8. If :math:`n` is :math:`0`, then:

   a. Do nothing.

9. Else:

   a. Push :math:`\I32-numtype.\CONST-instr-numeric~i` to the stack.

   b. Push :math:`val` to the stack.

   c. Execute :math:`\STORE-instr-state~\I32-numtype~{8}^?~0~0`.

   d. Push :math:`\I32-numtype.\CONST-instr-numeric~{i} + {1}` to the stack.

   e. Push :math:`val` to the stack.

   f. Push :math:`\I32-numtype.\CONST-instr-numeric~{n} - {1}` to the stack.

   g. Execute :math:`\MEMORYFILL-instr-state`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}memory.fill{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.fill}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}memory.fill{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.fill}) &\hookrightarrow& \epsilon &\quad
     \mbox{otherwise, if}~\mathit{n} = 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}memory.fill{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.fill}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{memory.fill}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _exec-MEMORY.COPY:


:math:`\MEMORYCOPY-instr-state`
...............................


1. Assert: Due to :ref:`validation <valid-MEMORY.COPY>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~n` from the stack.

3. Assert: Due to :ref:`validation <valid-MEMORY.COPY>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

4. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

5. Assert: Due to :ref:`validation <valid-MEMORY.COPY>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

6. Pop :math:`\I32-numtype.\CONST-instr-numeric~j` from the stack.

7. If :math:`{i} + {n}` is greater than the length of :math:`\mem-(0).\DATA-meminst` or :math:`{j} + {n}` is greater than the length of :math:`\mem-(0).\DATA-meminst`, then:

   a. Trap.

8. If :math:`n` is :math:`0`, then:

   a. Do nothing.

9. Else:

   a. If :math:`j` is less than or equal to :math:`i`, then:

      1) Push :math:`\I32-numtype.\CONST-instr-numeric~j` to the stack.

      2) Push :math:`\I32-numtype.\CONST-instr-numeric~i` to the stack.

      3) Execute :math:`\LOAD-instr-state~\I32-numtype~{8~\U-sx}^?~0~0`.

      4) Execute :math:`\STORE-instr-state~\I32-numtype~{8}^?~0~0`.

      5) Push :math:`\I32-numtype.\CONST-instr-numeric~{j} + {1}` to the stack.

      6) Push :math:`\I32-numtype.\CONST-instr-numeric~{i} + {1}` to the stack.

   b. Else:

      1) Push :math:`\I32-numtype.\CONST-instr-numeric~{{j} + {n}} - {1}` to the stack.

      2) Push :math:`\I32-numtype.\CONST-instr-numeric~{{i} + {n}} - {1}` to the stack.

      3) Execute :math:`\LOAD-instr-state~\I32-numtype~{8~\U-sx}^?~0~0`.

      4) Execute :math:`\STORE-instr-state~\I32-numtype~{8}^?~0~0`.

      5) Push :math:`\I32-numtype.\CONST-instr-numeric~j` to the stack.

      6) Push :math:`\I32-numtype.\CONST-instr-numeric~i` to the stack.

   c. Push :math:`\I32-numtype.\CONST-instr-numeric~{n} - {1}` to the stack.

   d. Execute :math:`\MEMORYCOPY-instr-state`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}memory.copy{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.copy}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}memory.copy{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.copy}) &\hookrightarrow& \epsilon &\quad
     \mbox{otherwise, if}~\mathit{n} = 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}memory.copy{-}le}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.copy}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~0~0)~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{memory.copy}) &\quad
     \mbox{otherwise, if}~\mathit{j} \leq \mathit{i} \\[0.8ex]
   {[\textsc{\scriptsize E{-}memory.copy{-}gt}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.copy}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + \mathit{n} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + \mathit{n} - 1)~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~0~0)~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{memory.copy}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _exec-MEMORY.INIT:


:math:`\MEMORYINIT-instr-state~x`
.................................


1. Assert: Due to :ref:`validation <valid-MEMORY.INIT>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~n` from the stack.

3. Assert: Due to :ref:`validation <valid-MEMORY.INIT>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

4. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

5. Assert: Due to :ref:`validation <valid-MEMORY.INIT>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

6. Pop :math:`\I32-numtype.\CONST-instr-numeric~j` from the stack.

7. If :math:`{i} + {n}` is greater than the length of :math:`\data-(x).\DATA-datainst` or :math:`{j} + {n}` is greater than the length of :math:`\mem-(0).\DATA-meminst`, then:

   a. Trap.

8. If :math:`n` is :math:`0`, then:

   a. Do nothing.

9. Else if :math:`i` is less than the length of :math:`\data-(x).\DATA-datainst`, then:

   a. Push :math:`\I32-numtype.\CONST-instr-numeric~j` to the stack.

   b. Push :math:`\I32-numtype.\CONST-instr-numeric~\data-(x).\DATA-datainst[i]` to the stack.

   c. Execute :math:`\STORE-instr-state~\I32-numtype~{8}^?~0~0`.

   d. Push :math:`\I32-numtype.\CONST-instr-numeric~{j} + {1}` to the stack.

   e. Push :math:`\I32-numtype.\CONST-instr-numeric~{i} + {1}` to the stack.

   f. Push :math:`\I32-numtype.\CONST-instr-numeric~{n} - {1}` to the stack.

   g. Execute :math:`\MEMORYINIT-instr-state~x`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}memory.init{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.init}~\mathit{x}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{data}}{[\mathit{x}]}.\mathsf{data}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}memory.init{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.init}~\mathit{x}) &\hookrightarrow& \epsilon &\quad
     \mbox{otherwise, if}~\mathit{n} = 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}memory.init{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.init}~\mathit{x}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{z}.\mathsf{data}}{[\mathit{x}]}.\mathsf{data}[\mathit{i}])~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{memory.init}~\mathit{x}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _exec-DATA.DROP:


:math:`\DATADROP-instr-state~x`
...............................


1. Perform :math:`\withdata-(x, \epsilon)`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}data.drop}]} \quad & \mathit{z} ; (\mathsf{data.drop}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{data}[\mathit{x}].\mathsf{data} = \epsilon] ; \epsilon &  \\
   \end{array}

.. _exec-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-NOP:


:math:`\NOP-instr-control`
..........................


1. Do nothing.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}nop}]} \quad & \mathsf{nop} &\hookrightarrow& \epsilon &  \\
   \end{array}

.. _exec-UNREACHABLE:


:math:`\UNREACHABLE-instr-control`
..................................


1. Trap.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}unreachable}]} \quad & \mathsf{unreachable} &\hookrightarrow& \mathsf{trap} &  \\
   \end{array}

.. _exec-BLOCK:


:math:`\BLOCK-instr-control~bt~{instr}{^\ast}`
..............................................


1. Let :math:`{t_{1}}{^{k}} \to {t_{2}}{^{n}}` be :math:`bt`.

2. Assert: Due to :ref:`validation <valid-BLOCK>`, there are at least :math:`k` values on the top of the stack.

3. Pop :math:`{val}{^{k}}` from the stack.

4. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is :math:`\epsilon`.

5. Push :math:`L` to the stack.

6. Push :math:`{val}{^{k}}` to the stack.

7. Jump to :math:`{instr}{^\ast}`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}block}]} \quad & {\mathit{val}^{\mathit{k}}}~(\mathsf{block}~\mathit{bt}~{\mathit{instr}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{\mathit{n}}}{\{\epsilon\}}~{\mathit{val}^{\mathit{k}}}~{\mathit{instr}^\ast}) &\quad
     \mbox{if}~\mathit{bt} = {\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}} \\
   \end{array}

.. _exec-LOOP:


:math:`\LOOP-instr-control~bt~{instr}{^\ast}`
.............................................


1. Let :math:`{t_{1}}{^{k}} \to {t_{2}}{^{n}}` be :math:`bt`.

2. Assert: Due to :ref:`validation <valid-LOOP>`, there are at least :math:`k` values on the top of the stack.

3. Pop :math:`{val}{^{k}}` from the stack.

4. Let :math:`L` be the label whose arity is :math:`k` and whose continuation is :math:`\LOOP-instr-control~bt~{instr}{^\ast}`.

5. Push :math:`L` to the stack.

6. Push :math:`{val}{^{k}}` to the stack.

7. Jump to :math:`{instr}{^\ast}`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}loop}]} \quad & {\mathit{val}^{\mathit{k}}}~(\mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{\mathit{k}}}{\{\mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast}\}}~{\mathit{val}^{\mathit{k}}}~{\mathit{instr}^\ast}) &\quad
     \mbox{if}~\mathit{bt} = {\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}} \\
   \end{array}

.. _exec-IF:


:math:`\IF-instr-control~bt~{instr_{1}}{^\ast}~{instr_{2}}{^\ast}`
..................................................................


1. Assert: Due to :ref:`validation <valid-IF>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~c` from the stack.

3. If :math:`c` is not :math:`0`, then:

   a. Execute :math:`\BLOCK-instr-control~bt~{instr_{1}}{^\ast}`.

4. Else:

   a. Execute :math:`\BLOCK-instr-control~bt~{instr_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{1}^\ast}) &\quad
     \mbox{if}~\mathit{c} \neq 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{2}^\ast}) &\quad
     \mbox{if}~\mathit{c} = 0 \\
   \end{array}

.. _exec-BR:


:math:`\BR-instr-control~x_{0}`
...............................


1. Let :math:`L` be the current label.

2. Let :math:`n` be the arity of :math:`L`.

3. Let :math:`{instr'}{^\ast}` be the continuation of :math:`L`.

4. Pop all values :math:`{x_{1}}{^\ast}` from the stack.

5. Exit current context.

6. If :math:`x_{0}` is :math:`0` and the length of :math:`{x_{1}}{^\ast}` is greater than or equal to :math:`n`, then:

   a. Let :math:`{val'}{^\ast}~{val}{^{n}}` be :math:`{x_{1}}{^\ast}`.

   b. Push :math:`{val}{^{n}}` to the stack.

   c. Execute the sequence :math:`{instr'}{^\ast}`.

7. If :math:`x_{0}` is greater than or equal to :math:`1`, then:

   a. Let :math:`l` be :math:`{x_{0}} - {1}`.

   b. Let :math:`{val}{^\ast}` be :math:`{x_{1}}{^\ast}`.

   c. Push :math:`{val}{^\ast}` to the stack.

   d. Execute :math:`\BR-instr-control~l`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}br{-}zero}]} \quad & ({{\mathsf{label}}_{\mathit{n}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}'}^\ast}~{\mathit{val}^{\mathit{n}}}~(\mathsf{br}~0)~{\mathit{instr}^\ast}) &\hookrightarrow& {\mathit{val}^{\mathit{n}}}~{{\mathit{instr}'}^\ast} &  \\[0.8ex]
   {[\textsc{\scriptsize E{-}br{-}succ}]} \quad & ({{\mathsf{label}}_{\mathit{n}}}{\{{{\mathit{instr}'}^\ast}\}}~{\mathit{val}^\ast}~(\mathsf{br}~\mathit{l} + 1)~{\mathit{instr}^\ast}) &\hookrightarrow& {\mathit{val}^\ast}~(\mathsf{br}~\mathit{l}) &  \\
   \end{array}

.. _exec-BR_IF:


:math:`\BRIF-instr-control~l`
.............................


1. Assert: Due to :ref:`validation <valid-BR_IF>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~c` from the stack.

3. If :math:`c` is not :math:`0`, then:

   a. Execute :math:`\BR-instr-control~l`.

4. Else:

   a. Do nothing.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}br\_if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{br\_if}~\mathit{l}) &\hookrightarrow& (\mathsf{br}~\mathit{l}) &\quad
     \mbox{if}~\mathit{c} \neq 0 \\[0.8ex]
   {[\textsc{\scriptsize E{-}br\_if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{br\_if}~\mathit{l}) &\hookrightarrow& \epsilon &\quad
     \mbox{if}~\mathit{c} = 0 \\
   \end{array}

.. _exec-BR_TABLE:


:math:`\BRTABLE-instr-control~{l}{^\ast}~l'`
............................................


1. Assert: Due to :ref:`validation <valid-BR_TABLE>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

3. If :math:`i` is less than the length of :math:`{l}{^\ast}`, then:

   a. Execute :math:`\BR-instr-control~{l}{^\ast}[i]`.

4. Else:

   a. Execute :math:`\BR-instr-control~l'`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}br\_table{-}lt}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}^\ast}[\mathit{i}]) &\quad
     \mbox{if}~\mathit{i} < {|{\mathit{l}^\ast}|} \\[0.8ex]
   {[\textsc{\scriptsize E{-}br\_table{-}ge}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}'}) &\quad
     \mbox{if}~\mathit{i} \geq {|{\mathit{l}^\ast}|} \\
   \end{array}

.. _exec-RETURN:


:math:`\RETURN-instr-control`
.............................


1. If the current context is frame, then:

   a. Let :math:`F` be the current frame.

   b. Let :math:`n` be the arity of :math:`F`.

   c. Pop :math:`{val}{^{n}}` from the stack.

   d. Pop all values :math:`{val'}{^\ast}` from the stack.

   e. Exit current context.

   f. Push :math:`{val}{^{n}}` to the stack.

2. Else if the current context is label, then:

   a. Pop all values :math:`{val}{^\ast}` from the stack.

   b. Exit current context.

   c. Push :math:`{val}{^\ast}` to the stack.

   d. Execute :math:`\RETURN-instr-control`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}return{-}frame}]} \quad & ({{\mathsf{frame}}_{\mathit{n}}}{\{\mathit{f}\}}~{{\mathit{val}'}^\ast}~{\mathit{val}^{\mathit{n}}}~\mathsf{return}~{\mathit{instr}^\ast}) &\hookrightarrow& {\mathit{val}^{\mathit{n}}} &  \\[0.8ex]
   {[\textsc{\scriptsize E{-}return{-}label}]} \quad & ({{\mathsf{label}}_{\mathit{k}}}{\{{{\mathit{instr}'}^\ast}\}}~{\mathit{val}^\ast}~\mathsf{return}~{\mathit{instr}^\ast}) &\hookrightarrow& {\mathit{val}^\ast}~\mathsf{return} &  \\
   \end{array}

.. _exec-CALL:


:math:`\CALL-instr-control~x`
.............................


1. If :math:`x` is less than the length of :math:`\funcaddr-()`, then:

   a. Execute :math:`\CALLADDR-admininstr~\funcaddr-()[x]`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}call}]} \quad & \mathit{z} ; (\mathsf{call}~\mathit{x}) &\hookrightarrow& (\mathsf{call}~\mathit{z}.\mathsf{module}.\mathsf{func}[\mathit{x}]) &  \\
   \end{array}

.. _exec-CALL_INDIRECT:


:math:`\CALLINDIRECT-instr-control~x~ft`
........................................


1. Assert: Due to :ref:`validation <valid-CALL_INDIRECT>`, a value of value type :math:`\I32-numtype` is on the top of the stack.

2. Pop :math:`\I32-numtype.\CONST-instr-numeric~i` from the stack.

3. If :math:`i` is greater than or equal to the length of :math:`\table-(x).\ELEM-tableinst`, then:

   a. Trap.

4. If :math:`\table-(x).\ELEM-tableinst[i]` is not of the case :math:`\REFFUNCADDR-ref`, then:

   a. Trap.

5. Let :math:`\REFFUNCADDR-ref~a` be :math:`\table-(x).\ELEM-tableinst[i]`.

6. If :math:`a` is greater than or equal to the length of :math:`\funcinst-()`, then:

   a. Trap.

7. If :math:`\funcinst-()[a].\CODE-funcinst` is not of the case :math:`\FUNC-func`, then:

   a. Trap.

8. Let :math:`\FUNC-func~ft'~{t}{^\ast}~{instr}{^\ast}` be :math:`\funcinst-()[a].\CODE-funcinst`.

9. If :math:`ft` is not :math:`ft'`, then:

   a. Trap.

10. Execute :math:`\CALLADDR-admininstr~a`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}call\_indirect{-}call}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{call\_indirect}~\mathit{x}~\mathit{ft}) &\hookrightarrow& (\mathsf{call}~\mathit{a}) &\quad
     \mbox{if}~{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}[\mathit{i}] = (\mathsf{ref.func}~\mathit{a}) \\
    &&&&\quad {\land}~\mathit{z}.\mathsf{func}[\mathit{a}].\mathsf{code} = \mathsf{func}~{\mathit{ft}'}~{\mathit{t}^\ast}~{\mathit{instr}^\ast} \\
    &&&&\quad {\land}~\mathit{ft} = {\mathit{ft}'} \\[0.8ex]
   {[\textsc{\scriptsize E{-}call\_indirect{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{call\_indirect}~\mathit{x}~\mathit{ft}) &\hookrightarrow& \mathsf{trap} &\quad
     \mbox{otherwise} \\
   \end{array}

.. _exec-instructions-seq:

Blocks
~~~~~~

.. _exec-LABEL_:


:math:`\LABEL-admininstr`
.........................


1. Pop all values :math:`{val}{^\ast}` from the stack.

2. Assert: Due to validation, a label is now on the top of the stack.

3. Pop the label from the stack.

4. Push :math:`{val}{^\ast}` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}label{-}vals}]} \quad & ({{\mathsf{label}}_{\mathit{n}}}{\{{\mathit{instr}^\ast}\}}~{\mathit{val}^\ast}) &\hookrightarrow& {\mathit{val}^\ast} &  \\
   \end{array}

Function Calls
~~~~~~~~~~~~~~

.. _exec-CALL_ADDR:


:math:`\CALLADDR-admininstr~a`
..............................


1. If :math:`a` is less than the length of :math:`\funcinst-()`, then:

   a. Let :math:`\{\MODULE-funcinst~m, \CODE-funcinst~func\}` be :math:`\funcinst-()[a]`.

   b. If :math:`func` is of the case :math:`\FUNC-func`, then:

      1) Let :math:`\FUNC-func~y_{0}~{t}{^\ast}~{instr}{^\ast}` be :math:`func`.

      2) Let :math:`{t_{1}}{^{k}} \to {t_{2}}{^{n}}` be :math:`y_{0}`.

      3) Assert: Due to validation, there are at least :math:`k` values on the top of the stack.

      4) Pop :math:`{val}{^{k}}` from the stack.

      5) Let :math:`f` be :math:`\{\LOCAL-frame~{val}{^{k}}~{(\default-(t))}{^\ast}, \MODULE-frame~m\}`.

      6) Push the activation of :math:`f` with arity :math:`n` to the stack.

      7) Let :math:`L` be the label whose arity is :math:`n` and whose continuation is :math:`\epsilon`.

      8) Push :math:`L` to the stack.

      9) Jump to :math:`{instr}{^\ast}`.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}call\_addr}]} \quad & \mathit{z} ; {\mathit{val}^{\mathit{k}}}~(\mathsf{call}~\mathit{a}) &\hookrightarrow& ({{\mathsf{frame}}_{\mathit{n}}}{\{\mathit{f}\}}~({{\mathsf{label}}_{\mathit{n}}}{\{\epsilon\}}~{\mathit{instr}^\ast})) &\quad
     \mbox{if}~\mathit{z}.\mathsf{func}[\mathit{a}] = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{module}~\mathit{m},\; \mathsf{code}~\mathit{func} \}\end{array} \\
    &&&&\quad {\land}~\mathit{func} = \mathsf{func}~({\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}})~{\mathit{t}^\ast}~{\mathit{instr}^\ast} \\
    &&&&\quad {\land}~\mathit{f} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{local}~{\mathit{val}^{\mathit{k}}}~{({\mathrm{default}}_{\mathit{t}})^\ast},\; \mathsf{module}~\mathit{m} \}\end{array} \\
   \end{array}

.. _exec-FRAME_:


:math:`\FRAME-admininstr`
.........................


1. Let :math:`f` be the current frame.

2. Let :math:`n` be the arity of :math:`f`.

3. Assert: Due to validation, there are at least :math:`n` values on the top of the stack.

4. Pop :math:`{val}{^{n}}` from the stack.

5. Assert: Due to validation, a frame is now on the top of the stack.

6. Pop the frame from the stack.

7. Push :math:`{val}{^{n}}` to the stack.



\

.. math::
   \begin{array}{@{}l@{}lcl@{}l@{}}
   {[\textsc{\scriptsize E{-}frame{-}vals}]} \quad & ({{\mathsf{frame}}_{\mathit{n}}}{\{\mathit{f}\}}~{\mathit{val}^{\mathit{n}}}) &\hookrightarrow& {\mathit{val}^{\mathit{n}}} &  \\
   \end{array}
