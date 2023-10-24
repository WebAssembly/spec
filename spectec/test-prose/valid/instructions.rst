.. _valid-instructions:

Instructions
------------

.. _valid-instructions-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-UNOP:


:math:`\UNOP-instr-numeric~nt~unop`
...................................


* The instruction is valid with type :math:`nt \to nt`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathit{nt} . \mathit{unop} : \mathit{nt} \rightarrow \mathit{nt}
   } \, {[\textsc{\scriptsize T{-}unop}]}
   \qquad
   \end{array}

.. _valid-BINOP:


:math:`\BINOP-instr-numeric~nt~binop`
.....................................


* The instruction is valid with type :math:`nt~nt \to nt`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathit{nt} . \mathit{binop} : \mathit{nt}~\mathit{nt} \rightarrow \mathit{nt}
   } \, {[\textsc{\scriptsize T{-}binop}]}
   \qquad
   \end{array}

.. _valid-TESTOP:


:math:`\TESTOP-instr-numeric~nt~testop`
.......................................


* The instruction is valid with type :math:`nt \to \I32-numtype`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathit{nt} . \mathit{testop} : \mathit{nt} \rightarrow \mathsf{i{\scriptstyle32}}
   } \, {[\textsc{\scriptsize T{-}testop}]}
   \qquad
   \end{array}

.. _valid-RELOP:


:math:`\RELOP-instr-numeric~nt~relop`
.....................................


* The instruction is valid with type :math:`nt~nt \to \I32-numtype`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathit{nt} . \mathit{relop} : \mathit{nt}~\mathit{nt} \rightarrow \mathsf{i{\scriptstyle32}}
   } \, {[\textsc{\scriptsize T{-}relop}]}
   \qquad
   \end{array}

.. _valid-REINTERPRET:

TODO (should change the rule name to cvtop-)

\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{nt}_{1} \neq \mathit{nt}_{2}
    \qquad
   {|\mathit{nt}_{1}|} = {|\mathit{nt}_{2}|}
   }{
   \mathit{C} \vdash \mathsf{cvtop}~\mathit{nt}_{1}~\mathsf{reinterpret}~\mathit{nt}_{2} : \mathit{nt}_{2} \rightarrow \mathit{nt}_{1}
   } \, {[\textsc{\scriptsize T{-}reinterpret}]}
   \qquad
   \end{array}

.. _valid-CONVERT:

TODO (should change the rule name to cvtop-)

\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   {\mathsf{i}}{\mathit{n}}_{1} \neq {\mathsf{i}}{\mathit{n}}_{2}
    \qquad
   {\mathit{sx}^?} = \epsilon \Leftrightarrow {|{\mathsf{i}}{\mathit{n}}_{1}|} > {|{\mathsf{i}}{\mathit{n}}_{2}|}
   }{
   \mathit{C} \vdash {\mathsf{i}}{\mathit{n}}_{1} . {{{{\mathsf{convert}}{\mathsf{\_}}}{{\mathsf{i}}{\mathit{n}}_{2}}}{\mathsf{\_}}}{{\mathit{sx}^?}} : {\mathsf{i}}{\mathit{n}}_{2} \rightarrow {\mathsf{i}}{\mathit{n}}_{1}
   } \, {[\textsc{\scriptsize T{-}convert{-}i}]}
   \\[3ex]\displaystyle
   \frac{
   {\mathsf{f}}{\mathit{n}}_{1} \neq {\mathsf{f}}{\mathit{n}}_{2}
   }{
   \mathit{C} \vdash \mathsf{cvtop}~{\mathsf{f}}{\mathit{n}}_{1}~\mathsf{convert}~{\mathsf{f}}{\mathit{n}}_{2} : {\mathsf{f}}{\mathit{n}}_{2} \rightarrow {\mathsf{f}}{\mathit{n}}_{1}
   } \, {[\textsc{\scriptsize T{-}convert{-}f}]}
   \qquad
   \end{array}

.. _valid-instructions-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-REF.IS_NULL:


:math:`\REFISNULL-instr-reference`
..................................


* The instruction is valid with type :math:`rt \to \I32-numtype`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathsf{ref.is\_null} : \mathit{rt} \rightarrow \mathsf{i{\scriptstyle32}}
   } \, {[\textsc{\scriptsize T{-}ref.is\_null}]}
   \qquad
   \end{array}

.. _valid-REF.FUNC:


:math:`\REFFUNC-instr-reference~x`
..................................


* The length of :math:`C.\FUNC-context` must be greater than :math:`x`.

* Let :math:`ft` be :math:`C.\FUNC-context[x]`.

* The instruction is valid with type :math:`\epsilon \to \FUNCREF-reftype`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{func}[\mathit{x}] = \mathit{ft}
   }{
   \mathit{C} \vdash \mathsf{ref.func}~\mathit{x} : \epsilon \rightarrow \mathsf{funcref}
   } \, {[\textsc{\scriptsize T{-}ref.func}]}
   \qquad
   \end{array}

.. _valid-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-DROP:


:math:`\DROP-instr-control`
...........................


* The instruction is valid with type :math:`t \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathsf{drop} : \mathit{t} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}drop}]}
   \qquad
   \end{array}

.. _valid-SELECT:


:math:`\SELECT-instr-control~{t}^?`
...................................


* The instruction is valid with type :math:`t~t~\I32-numtype \to t`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathsf{select}~\mathit{t} : \mathit{t}~\mathit{t}~\mathsf{i{\scriptstyle32}} \rightarrow \mathit{t}
   } \, {[\textsc{\scriptsize T{-}select{-}expl}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{t} \leq {\mathit{t}'}
    \qquad
   {\mathit{t}'} = \mathit{numtype} \lor {\mathit{t}'} = \mathit{vectype}
   }{
   \mathit{C} \vdash \mathsf{select} : \mathit{t}~\mathit{t}~\mathsf{i{\scriptstyle32}} \rightarrow \mathit{t}
   } \, {[\textsc{\scriptsize T{-}select{-}impl}]}
   \qquad
   \end{array}

.. _valid-instructions-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-LOCAL.GET:


:math:`\LOCALGET-instr-state~x`
...............................


* The length of :math:`C.\LOCAL-context` must be greater than :math:`x`.

* Let :math:`t` be :math:`C.\LOCAL-context[x]`.

* The instruction is valid with type :math:`\epsilon \to t`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
   }{
   \mathit{C} \vdash \mathsf{local.get}~\mathit{x} : \epsilon \rightarrow \mathit{t}
   } \, {[\textsc{\scriptsize T{-}local.get}]}
   \qquad
   \end{array}

.. _valid-LOCAL.SET:


:math:`\LOCALSET-instr-state~x`
...............................


* The length of :math:`C.\LOCAL-context` must be greater than :math:`x`.

* Let :math:`t` be :math:`C.\LOCAL-context[x]`.

* The instruction is valid with type :math:`t \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
   }{
   \mathit{C} \vdash \mathsf{local.set}~\mathit{x} : \mathit{t} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}local.set}]}
   \qquad
   \end{array}

.. _valid-LOCAL.TEE:


:math:`\LOCALTEE-instr-state~x`
...............................


* The length of :math:`C.\LOCAL-context` must be greater than :math:`x`.

* Let :math:`t` be :math:`C.\LOCAL-context[x]`.

* The instruction is valid with type :math:`t \to t`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
   }{
   \mathit{C} \vdash \mathsf{local.tee}~\mathit{x} : \mathit{t} \rightarrow \mathit{t}
   } \, {[\textsc{\scriptsize T{-}local.tee}]}
   \qquad
   \end{array}

.. _valid-GLOBAL.GET:


:math:`\GLOBALGET-instr-state~x`
................................


* The length of :math:`C.\GLOBAL-context` must be greater than :math:`x`.

* Let :math:`{mut}{^?}~t` be :math:`C.\GLOBAL-context[x]`.

* The instruction is valid with type :math:`\epsilon \to t`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{global}[\mathit{x}] = {\mathsf{mut}^?}~\mathit{t}
   }{
   \mathit{C} \vdash \mathsf{global.get}~\mathit{x} : \epsilon \rightarrow \mathit{t}
   } \, {[\textsc{\scriptsize T{-}global.get}]}
   \qquad
   \end{array}

.. _valid-GLOBAL.SET:


:math:`\GLOBALSET-instr-state~x`
................................


* The length of :math:`C.\GLOBAL-context` must be greater than :math:`x`.

* Let :math:`\MUT-globaltype~t` be :math:`C.\GLOBAL-context[x]`.

* The instruction is valid with type :math:`t \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{global}[\mathit{x}] = \mathsf{mut}~\mathit{t}
   }{
   \mathit{C} \vdash \mathsf{global.set}~\mathit{x} : \mathit{t} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}global.set}]}
   \qquad
   \end{array}

.. _valid-instructions-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-TABLE.GET:


:math:`\TABLEGET-instr-state~x`
...............................


* The length of :math:`C.\TABLE-context` must be greater than :math:`x`.

* Let :math:`lim~rt` be :math:`C.\TABLE-context[x]`.

* The instruction is valid with type :math:`\I32-numtype \to rt`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
   }{
   \mathit{C} \vdash \mathsf{table.get}~\mathit{x} : \mathsf{i{\scriptstyle32}} \rightarrow \mathit{rt}
   } \, {[\textsc{\scriptsize T{-}table.get}]}
   \qquad
   \end{array}

.. _valid-TABLE.SET:


:math:`\TABLESET-instr-state~x`
...............................


* The length of :math:`C.\TABLE-context` must be greater than :math:`x`.

* Let :math:`lim~rt` be :math:`C.\TABLE-context[x]`.

* The instruction is valid with type :math:`\I32-numtype~rt \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
   }{
   \mathit{C} \vdash \mathsf{table.set}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathit{rt} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}table.set}]}
   \qquad
   \end{array}

.. _valid-TABLE.SIZE:


:math:`\TABLESIZE-instr-state~x`
................................


* The length of :math:`C.\TABLE-context` must be greater than :math:`x`.

* Let :math:`tt` be :math:`C.\TABLE-context[x]`.

* The instruction is valid with type :math:`\epsilon \to \I32-numtype`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{tt}
   }{
   \mathit{C} \vdash \mathsf{table.size}~\mathit{x} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
   } \, {[\textsc{\scriptsize T{-}table.size}]}
   \qquad
   \end{array}

.. _valid-TABLE.GROW:


:math:`\TABLEGROW-instr-state~x`
................................


* The length of :math:`C.\TABLE-context` must be greater than :math:`x`.

* Let :math:`lim~rt` be :math:`C.\TABLE-context[x]`.

* The instruction is valid with type :math:`rt~\I32-numtype \to \I32-numtype`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
   }{
   \mathit{C} \vdash \mathsf{table.grow}~\mathit{x} : \mathit{rt}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
   } \, {[\textsc{\scriptsize T{-}table.grow}]}
   \qquad
   \end{array}

.. _valid-TABLE.FILL:


:math:`\TABLEFILL-instr-state~x`
................................


* The length of :math:`C.\TABLE-context` must be greater than :math:`x`.

* Let :math:`lim~rt` be :math:`C.\TABLE-context[x]`.

* The instruction is valid with type :math:`\I32-numtype~rt~\I32-numtype \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
   }{
   \mathit{C} \vdash \mathsf{table.fill}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathit{rt}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}table.fill}]}
   \qquad
   \end{array}

.. _valid-TABLE.COPY:


:math:`\TABLECOPY-instr-state~x_{1}~x_{2}`
..........................................


* The length of :math:`C.\TABLE-context` must be greater than :math:`x_{1}`.

* The length of :math:`C.\TABLE-context` must be greater than :math:`x_{2}`.

* Let :math:`lim_{1}~rt` be :math:`C.\TABLE-context[x_{1}]`.

* Let :math:`lim_{2}~rt` be :math:`C.\TABLE-context[x_{2}]`.

* The instruction is valid with type :math:`\I32-numtype~\I32-numtype~\I32-numtype \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}_{1}] = \mathit{lim}_{1}~\mathit{rt}
    \qquad
   \mathit{C}.\mathsf{table}[\mathit{x}_{2}] = \mathit{lim}_{2}~\mathit{rt}
   }{
   \mathit{C} \vdash \mathsf{table.copy}~\mathit{x}_{1}~\mathit{x}_{2} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}table.copy}]}
   \qquad
   \end{array}

.. _valid-TABLE.INIT:


:math:`\TABLEINIT-instr-state~x_{1}~x_{2}`
..........................................


* The length of :math:`C.\TABLE-context` must be greater than :math:`x_{1}`.

* The length of :math:`C.\ELEM-context` must be greater than :math:`x_{2}`.

* Let :math:`lim~rt` be :math:`C.\TABLE-context[x_{1}]`.

* :math:`C.\ELEM-context[x_{2}]` must be equal to :math:`rt`.

* The instruction is valid with type :math:`\I32-numtype~\I32-numtype~\I32-numtype \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}_{1}] = \mathit{lim}~\mathit{rt}
    \qquad
   \mathit{C}.\mathsf{elem}[\mathit{x}_{2}] = \mathit{rt}
   }{
   \mathit{C} \vdash \mathsf{table.init}~\mathit{x}_{1}~\mathit{x}_{2} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}table.init}]}
   \qquad
   \end{array}

.. _valid-ELEM.DROP:


:math:`\ELEMDROP-instr-state~x`
...............................


* The length of :math:`C.\ELEM-context` must be greater than :math:`x`.

* Let :math:`rt` be :math:`C.\ELEM-context[x]`.

* The instruction is valid with type :math:`\epsilon \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{elem}[\mathit{x}] = \mathit{rt}
   }{
   \mathit{C} \vdash \mathsf{elem.drop}~\mathit{x} : \epsilon \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}elem.drop}]}
   \qquad
   \end{array}

.. _valid-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-LOAD:


:math:`\LOAD-instr-state~nt~{(n~sx)}{^?}~n_{A}~n_{O}`
.....................................................


* The length of :math:`C.\MEM-context` must be greater than :math:`0`.

* :math:`{n}{^?}` is :math:`\epsilon` and :math:`{sx}{^?}` is :math:`\epsilon` are equivalent.

* :math:`{2} ^ {n_{A}}` must be less than or equal to :math:`{\size-(nt)} / {8}`.

* If :math:`n` is defined,

   * :math:`{2} ^ {n_{A}}` must be less than or equal to :math:`{n} / {8}`.

   * :math:`{n} / {8}` must be less than :math:`{\size-(nt)} / {8}`.

* :math:`C.\MEM-context[0]` must be equal to :math:`mt`.

* If :math:`n` is defined,

   * :math:`nt` must be equal to :math:`in`.

* The instruction is valid with type :math:`\I32-numtype \to nt`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[0] = \mathit{mt}
    \qquad
   {2^{\mathit{n}_{\mathsf{a}}}} \leq {|\mathit{nt}|} / 8
    \qquad
   ({2^{\mathit{n}_{\mathsf{a}}}} \leq \mathit{n} / 8 < {|\mathit{nt}|} / 8)^?
    \qquad
   {\mathit{n}^?} = \epsilon \lor \mathit{nt} = {\mathsf{i}}{\mathit{n}}
   }{
   \mathit{C} \vdash {\mathit{nt}.\mathsf{load}}{{({{\mathit{n}}{\mathsf{\_}}}{\mathit{sx}})^?}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathit{nt}
   } \, {[\textsc{\scriptsize T{-}load}]}
   \qquad
   \end{array}

.. _valid-STORE:


:math:`\STORE-instr-state~nt~{n}{^?}~n_{A}~n_{O}`
.................................................


* The length of :math:`C.\MEM-context` must be greater than :math:`0`.

* :math:`{2} ^ {n_{A}}` must be less than or equal to :math:`{\size-(nt)} / {8}`.

* If :math:`n` is defined,

   * :math:`{2} ^ {n_{A}}` must be less than or equal to :math:`{n} / {8}`.

   * :math:`{n} / {8}` must be less than :math:`{\size-(nt)} / {8}`.

* :math:`C.\MEM-context[0]` must be equal to :math:`mt`.

* If :math:`n` is defined,

   * :math:`nt` must be equal to :math:`in`.

* The instruction is valid with type :math:`\I32-numtype~nt \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[0] = \mathit{mt}
    \qquad
   {2^{\mathit{n}_{\mathsf{a}}}} \leq {|\mathit{nt}|} / 8
    \qquad
   ({2^{\mathit{n}_{\mathsf{a}}}} \leq \mathit{n} / 8 < {|\mathit{nt}|} / 8)^?
    \qquad
   {\mathit{n}^?} = \epsilon \lor \mathit{nt} = {\mathsf{i}}{\mathit{n}}
   }{
   \mathit{C} \vdash {\mathit{nt}.\mathsf{store}}{{\mathit{n}^?}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}} : \mathsf{i{\scriptstyle32}}~\mathit{nt} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}store}]}
   \qquad
   \end{array}

.. _valid-MEMORY.SIZE:


:math:`\MEMORYSIZE-instr-state`
...............................


* The length of :math:`C.\MEM-context` must be greater than :math:`0`.

* Let :math:`mt` be :math:`C.\MEM-context[0]`.

* The instruction is valid with type :math:`\epsilon \to \I32-numtype`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[0] = \mathit{mt}
   }{
   \mathit{C} \vdash \mathsf{memory.size} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
   } \, {[\textsc{\scriptsize T{-}memory.size}]}
   \qquad
   \end{array}

.. _valid-MEMORY.GROW:


:math:`\MEMORYGROW-instr-state`
...............................


* The length of :math:`C.\MEM-context` must be greater than :math:`0`.

* Let :math:`mt` be :math:`C.\MEM-context[0]`.

* The instruction is valid with type :math:`\I32-numtype \to \I32-numtype`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[0] = \mathit{mt}
   }{
   \mathit{C} \vdash \mathsf{memory.grow} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
   } \, {[\textsc{\scriptsize T{-}memory.grow}]}
   \qquad
   \end{array}

.. _valid-MEMORY.FILL:


:math:`\MEMORYFILL-instr-state`
...............................


* The length of :math:`C.\MEM-context` must be greater than :math:`0`.

* Let :math:`mt` be :math:`C.\MEM-context[0]`.

* The instruction is valid with type :math:`\I32-numtype~\I32-numtype~\I32-numtype \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[0] = \mathit{mt}
   }{
   \mathit{C} \vdash \mathsf{memory.fill} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}memory.fill}]}
   \qquad
   \end{array}

.. _valid-MEMORY.COPY:


:math:`\MEMORYCOPY-instr-state`
...............................


* The length of :math:`C.\MEM-context` must be greater than :math:`0`.

* Let :math:`mt` be :math:`C.\MEM-context[0]`.

* The instruction is valid with type :math:`\I32-numtype~\I32-numtype~\I32-numtype \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[0] = \mathit{mt}
   }{
   \mathit{C} \vdash \mathsf{memory.copy} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}memory.copy}]}
   \qquad
   \end{array}

.. _valid-MEMORY.INIT:


:math:`\MEMORYINIT-instr-state~x`
.................................


* The length of :math:`C.\MEM-context` must be greater than :math:`0`.

* The length of :math:`C.\DATA-context` must be greater than :math:`x`.

* :math:`C.\DATA-context[x]` must be equal to :math:`\OK-datatype`.

* Let :math:`mt` be :math:`C.\MEM-context[0]`.

* The instruction is valid with type :math:`\I32-numtype~\I32-numtype~\I32-numtype \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[0] = \mathit{mt}
    \qquad
   \mathit{C}.\mathsf{data}[\mathit{x}] = \mathsf{ok}
   }{
   \mathit{C} \vdash \mathsf{memory.init}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}memory.init}]}
   \qquad
   \end{array}

.. _valid-DATA.DROP:


:math:`\DATADROP-instr-state~x`
...............................


* The length of :math:`C.\DATA-context` must be greater than :math:`x`.

* :math:`C.\DATA-context[x]` must be equal to :math:`\OK-datatype`.

* The instruction is valid with type :math:`\epsilon \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{data}[\mathit{x}] = \mathsf{ok}
   }{
   \mathit{C} \vdash \mathsf{data.drop}~\mathit{x} : \epsilon \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}data.drop}]}
   \qquad
   \end{array}

.. _valid-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-NOP:


:math:`\NOP-instr-control`
..........................


* The instruction is valid with type :math:`\epsilon \to \epsilon`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
   } \, {[\textsc{\scriptsize T{-}nop}]}
   \qquad
   \end{array}

.. _valid-UNREACHABLE:


:math:`\UNREACHABLE-instr-control`
..................................


* The instruction is valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathsf{unreachable} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}unreachable}]}
   \qquad
   \end{array}

.. _valid-BLOCK:


:math:`\BLOCK-instr-control~bt~{instr}{^\ast}`
..............................................


* Under the context :math:`C` with :math:`.\LABEL-context` prepended by :math:`{t_{2}}{^\ast}`, :math:`{instr}{^\ast}` must be valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.

* Under the context :math:`C`, :math:`bt` must be valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.

* The instruction is valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
    \qquad
   \mathit{C}, \mathsf{label}~({\mathit{t}_{2}^\ast}) \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   }{
   \mathit{C} \vdash \mathsf{block}~\mathit{bt}~{\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}block}]}
   \qquad
   \end{array}

.. _valid-LOOP:


:math:`\LOOP-instr-control~bt~{instr}{^\ast}`
.............................................


* Under the context :math:`C` with :math:`.\LABEL-context` prepended by :math:`{t_{1}}{^\ast}`, :math:`{instr}{^\ast}` must be valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.

* Under the context :math:`C`, :math:`bt` must be valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.

* The instruction is valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
    \qquad
   \mathit{C}, \mathsf{label}~({\mathit{t}_{1}^\ast}) \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   }{
   \mathit{C} \vdash \mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}loop}]}
   \qquad
   \end{array}

.. _valid-IF:


:math:`\IF-instr-control~bt~{instr_{1}}{^\ast}~{instr_{2}}{^\ast}`
..................................................................


* Under the context :math:`C` with :math:`.\LABEL-context` prepended by :math:`{t_{2}}{^\ast}`, :math:`{instr_{2}}{^\ast}` must be valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.

* Under the context :math:`C`, :math:`bt` must be valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.

* Under the context :math:`C` with :math:`.\LABEL-context` prepended by :math:`{t_{2}}{^\ast}`, :math:`{instr_{1}}{^\ast}` must be valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.

* The instruction is valid with type :math:`{t_{1}}{^\ast}~\I32-numtype \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
    \qquad
   \mathit{C}, \mathsf{label}~({\mathit{t}_{2}^\ast}) \vdash {\mathit{instr}_{1}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
    \qquad
   \mathit{C}, \mathsf{label}~({\mathit{t}_{2}^\ast}) \vdash {\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   }{
   \mathit{C} \vdash \mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}if}]}
   \qquad
   \end{array}

.. _valid-BR:


:math:`\BR-instr-control~l`
...........................


* The length of :math:`C.\LABEL-context` must be greater than :math:`l`.

* Let :math:`{t}{^\ast}` be :math:`C.\LABEL-context[l]`.

* The instruction is valid with type :math:`{t_{1}}{^\ast}~{t}{^\ast} \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{label}[\mathit{l}] = {\mathit{t}^\ast}
   }{
   \mathit{C} \vdash \mathsf{br}~\mathit{l} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}br}]}
   \qquad
   \end{array}

.. _valid-BR_IF:


:math:`\BRIF-instr-control~l`
.............................


* The length of :math:`C.\LABEL-context` must be greater than :math:`l`.

* Let :math:`{t}{^\ast}` be :math:`C.\LABEL-context[l]`.

* The instruction is valid with type :math:`{t}{^\ast}~\I32-numtype \to {t}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{label}[\mathit{l}] = {\mathit{t}^\ast}
   }{
   \mathit{C} \vdash \mathsf{br\_if}~\mathit{l} : {\mathit{t}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}^\ast}
   } \, {[\textsc{\scriptsize T{-}br\_if}]}
   \qquad
   \end{array}

.. _valid-BR_TABLE:


:math:`\BRTABLE-instr-control~{l}{^\ast}~l'`
............................................


* For all :math:`l` in :math:`{l}{^\ast}`,

   * The length of :math:`C.\LABEL-context` must be greater than :math:`l`.

* The length of :math:`C.\LABEL-context` must be greater than :math:`l'`.

* For all :math:`l` in :math:`{l}{^\ast}`,

   * :math:`{t}{^\ast}` must match :math:`C.\LABEL-context[l]`.

* :math:`{t}{^\ast}` must match :math:`C.\LABEL-context[l']`.

* The instruction is valid with type :math:`{t_{1}}{^\ast}~{t}{^\ast} \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   ({ \vdash }\;{\mathit{t}^\ast} \leq \mathit{C}.\mathsf{label}[\mathit{l}])^\ast
    \qquad
   { \vdash }\;{\mathit{t}^\ast} \leq \mathit{C}.\mathsf{label}[{\mathit{l}'}]
   }{
   \mathit{C} \vdash \mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}br\_table}]}
   \qquad
   \end{array}

.. _valid-RETURN:


:math:`\RETURN-instr-control`
.............................


* Let :math:`{{t}{^\ast}}^?` be :math:`C.\RETURN-context`.

* The instruction is valid with type :math:`{t_{1}}{^\ast}~{t}{^\ast} \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{return} = ({\mathit{t}^\ast})
   }{
   \mathit{C} \vdash \mathsf{return} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}return}]}
   \qquad
   \end{array}

.. _valid-CALL:


:math:`\CALL-instr-control~x`
.............................


* The length of :math:`C.\FUNC-context` must be greater than :math:`x`.

* Let :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}` be :math:`C.\FUNC-context[x]`.

* The instruction is valid with type :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{func}[\mathit{x}] = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   }{
   \mathit{C} \vdash \mathsf{call}~\mathit{x} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}call}]}
   \qquad
   \end{array}

.. _valid-CALL_INDIRECT:


:math:`\CALLINDIRECT-instr-control~x~ft`
........................................


* The length of :math:`C.\TABLE-context` must be greater than :math:`x`.

* Let :math:`lim~\FUNCREF-reftype` be :math:`C.\TABLE-context[x]`.

* Let :math:`{t_{1}}{^\ast} \to {t_{2}}{^\ast}` be :math:`ft`.

* The instruction is valid with type :math:`{t_{1}}{^\ast}~\I32-numtype \to {t_{2}}{^\ast}`.



\

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathsf{funcref}
    \qquad
   \mathit{ft} = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
   }{
   \mathit{C} \vdash \mathsf{call\_indirect}~\mathit{x}~\mathit{ft} : {\mathit{t}_{1}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}_{2}^\ast}
   } \, {[\textsc{\scriptsize T{-}call\_indirect}]}
   \qquad
   \end{array}
