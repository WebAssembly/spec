.. _exec-runtime:

Runtime
-------

.. _exec-runtime-values:

Values
~~~~~~

.. _def-default_:


:math:`\default-(x_{0})`
........................


1. If :math:`x_{0}` is :math:`\I32-numtype`, then:

   a. Return :math:`\I32-numtype.\CONST-num~0`.

2. If :math:`x_{0}` is :math:`\I64-numtype`, then:

   a. Return :math:`\I64-numtype.\CONST-num~0`.

3. If :math:`x_{0}` is :math:`\F32-numtype`, then:

   a. Return :math:`\F32-numtype.\CONST-num~0`.

4. If :math:`x_{0}` is :math:`\F64-numtype`, then:

   a. Return :math:`\F64-numtype.\CONST-num~0`.

5. If :math:`x_{0}` is :math:`\FUNCREF-reftype`, then:

   a. Return :math:`\REFNULL-ref~\FUNCREF-reftype`.

6. If :math:`x_{0}` is :math:`\EXTERNREF-reftype`, then:

   a. Return :math:`\REFNULL-ref~\EXTERNREF-reftype`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {\mathrm{default}}_{\mathsf{i{\scriptstyle32}}} &=& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &  \\[0.8ex]
   {\mathrm{default}}_{\mathsf{i{\scriptstyle64}}} &=& (\mathsf{i{\scriptstyle64}}.\mathsf{const}~0) &  \\[0.8ex]
   {\mathrm{default}}_{\mathsf{f{\scriptstyle32}}} &=& (\mathsf{f{\scriptstyle32}}.\mathsf{const}~0) &  \\[0.8ex]
   {\mathrm{default}}_{\mathsf{f{\scriptstyle64}}} &=& (\mathsf{f{\scriptstyle64}}.\mathsf{const}~0) &  \\[0.8ex]
   {\mathrm{default}}_{\mathsf{funcref}} &=& (\mathsf{ref.null}~\mathsf{funcref}) &  \\[0.8ex]
   {\mathrm{default}}_{\mathsf{externref}} &=& (\mathsf{ref.null}~\mathsf{externref}) &  \\
   \end{array}

.. _exec-runtime-results:

Results
~~~~~~~

.. _syntax-store:
.. _exec-runtime-store:

Store
~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{store} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{func}~{\mathit{funcinst}^\ast},\; \\
     \mathsf{global}~{\mathit{globalinst}^\ast},\; \\
     \mathsf{table}~{\mathit{tableinst}^\ast},\; \\
     \mathsf{mem}~{\mathit{meminst}^\ast},\; \\
     \mathsf{elem}~{\mathit{eleminst}^\ast},\; \\
     \mathsf{data}~{\mathit{datainst}^\ast} \;\}\end{array} \\
   \end{array}

.. _syntax-addr:
.. _syntax-funcaddr:
.. _syntax-globaladdr:
.. _syntax-tableaddr:
.. _syntax-memaddr:
.. _syntax-elemaddr:
.. _syntax-dataaddr:
.. _syntax-labeladdr:
.. _syntax-hostaddr:
.. _exec-runtime-addresses:

Addresses
~~~~~~~~~

.. math::
   \begin{array}{@{}lrrl@{}}
   \mbox{(address)} & \mathit{addr} &::=& \mathit{nat} \\[0.8ex]
   \mbox{(function address)} & \mathit{funcaddr} &::=& \mathit{addr} \\[0.8ex]
   \mbox{(global address)} & \mathit{globaladdr} &::=& \mathit{addr} \\[0.8ex]
   \mbox{(table address)} & \mathit{tableaddr} &::=& \mathit{addr} \\[0.8ex]
   \mbox{(memory address)} & \mathit{memaddr} &::=& \mathit{addr} \\[0.8ex]
   \mbox{(elem address)} & \mathit{elemaddr} &::=& \mathit{addr} \\[0.8ex]
   \mbox{(data address)} & \mathit{dataaddr} &::=& \mathit{addr} \\[0.8ex]
   \mbox{(label address)} & \mathit{labeladdr} &::=& \mathit{addr} \\[0.8ex]
   \mbox{(host address)} & \mathit{hostaddr} &::=& \mathit{addr} \\
   \end{array}

.. _syntax-moduleinst:
.. _exec-runtime-module-instances:

Module Instances
~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{moduleinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{func}~{\mathit{funcaddr}^\ast},\; \\
     \mathsf{global}~{\mathit{globaladdr}^\ast},\; \\
     \mathsf{table}~{\mathit{tableaddr}^\ast},\; \\
     \mathsf{mem}~{\mathit{memaddr}^\ast},\; \\
     \mathsf{elem}~{\mathit{elemaddr}^\ast},\; \\
     \mathsf{data}~{\mathit{dataaddr}^\ast},\; \\
     \mathsf{export}~{\mathit{exportinst}^\ast} \;\}\end{array} \\
   \end{array}

.. _syntax-funcinst:
.. _exec-runtime-function-instances:

Function Instances
~~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{funcinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{module}~\mathit{moduleinst},\; \\
     \mathsf{code}~\mathit{func} \;\}\end{array} \\
   \end{array}

.. _syntax-tableinst:
.. _exec-runtime-table-instances:

Table Instances
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{tableinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{type}~\mathit{tabletype},\; \\
     \mathsf{elem}~{\mathit{ref}^\ast} \;\}\end{array} \\
   \end{array}

.. _syntax-meminst:
.. _exec-runtime-memory-instances:

Memory Instances
~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{meminst} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{type}~\mathit{memtype},\; \\
     \mathsf{data}~{\mathit{byte}^\ast} \;\}\end{array} \\
   \end{array}

.. _syntax-globalinst:
.. _exec-runtime-global-instances:

Global Instances
~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{globalinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{type}~\mathit{globaltype},\; \\
     \mathsf{value}~\mathit{val} \;\}\end{array} \\
   \end{array}

.. _syntax-eleminst:
.. _exec-runtime-element-instances:

Element Instances
~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{eleminst} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{type}~\mathit{elemtype},\; \\
     \mathsf{elem}~{\mathit{ref}^\ast} \;\}\end{array} \\
   \end{array}

.. _syntax-datainst:
.. _exec-runtime-data-instances:

Data Instances
~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{datainst} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{data}~{\mathit{byte}^\ast} \;\}\end{array} \\
   \end{array}

.. _syntax-exportinst:
.. _exec-runtime-export-instances:

Export Instances
~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{exportinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{name}~\mathit{name},\; \\
     \mathsf{value}~\mathit{externval} \;\}\end{array} \\
   \end{array}

.. _syntax-externval:
.. _exec-runtime-external-values:

External Values
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{externval} &::=& \mathsf{func}~\mathit{funcaddr} ~|~ \mathsf{global}~\mathit{globaladdr} ~|~ \mathsf{table}~\mathit{tableaddr} ~|~ \mathsf{mem}~\mathit{memaddr} \\
   \end{array}

.. _exec-runtime-stack:

Stack
~~~~~

.. _syntax-frame:

Activation Frames
.................

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{frame} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{local}~{\mathit{val}^\ast},\; \\
     \mathsf{module}~\mathit{moduleinst} \;\}\end{array} \\
   \end{array}

.. _syntax-admininstr:
.. _exec-runtime-administrative-instructions:

Administrative Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{instr} &::=& \mathit{instr} \\ &&|&
   \mathsf{ref.func}~\mathit{funcaddr} \\ &&|&
   \mathsf{ref.extern}~\mathit{hostaddr} \\ &&|&
   \mathsf{call}~\mathit{funcaddr} \\ &&|&
   {{\mathsf{label}}_{\mathit{n}}}{\{{\mathit{instr}^\ast}\}}~{\mathit{instr}^\ast} \\ &&|&
   {{\mathsf{frame}}_{\mathit{n}}}{\{\mathit{frame}\}}~{\mathit{instr}^\ast} \\ &&|&
   \mathsf{trap} \\
   \end{array}

.. _syntax-state:
.. _syntax-config:

Configurations
..............

.. math::
   \begin{array}{@{}lrrl@{}}
   \mbox{(state)} & \mathit{state} &::=& \mathit{store} ; \mathit{frame} \\[0.8ex]
   \mbox{(configuration)} & \mathit{config} &::=& \mathit{state} ; {\mathit{instr}^\ast} \\
   \end{array}

.. _syntax-E:

Evaluation Contexts
...................

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{E} &::=& [\mathsf{\_}] \\ &&|&
   {\mathit{val}^\ast}~\mathit{E}~{\mathit{instr}^\ast} \\ &&|&
   {{\mathsf{label}}_{\mathit{n}}}{\{{\mathit{instr}^\ast}\}}~\mathit{E} \\
   \end{array}

.. _exec-runtime-helper-functions:

Helper Functions
~~~~~~~~~~~~~~~~

.. _def-funcaddr:


:math:`\funcaddr-()`
....................


1. Let :math:`f` be the current frame.

2. Return :math:`f.\MODULE-frame.\FUNC-moduleinst`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f}).\mathsf{module}.\mathsf{func} &=& \mathit{f}.\mathsf{module}.\mathsf{func} &  \\
   \end{array}

.. _def-funcinst:


:math:`\funcinst-()`
....................


1. Return :math:`s.\FUNC-store`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f}).\mathsf{func} &=& \mathit{s}.\mathsf{func} &  \\
   \end{array}

.. _def-globalinst:


:math:`\globalinst-()`
......................


1. Return :math:`s.\GLOBAL-store`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f}).\mathsf{global} &=& \mathit{s}.\mathsf{global} &  \\
   \end{array}

.. _def-tableinst:


:math:`\tableinst-()`
.....................


1. Return :math:`s.\TABLE-store`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f}).\mathsf{table} &=& \mathit{s}.\mathsf{table} &  \\
   \end{array}

.. _def-meminst:


:math:`\meminst-()`
...................


1. Return :math:`s.\MEM-store`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f}).\mathsf{mem} &=& \mathit{s}.\mathsf{mem} &  \\
   \end{array}

.. _def-eleminst:


:math:`\eleminst-()`
....................


1. Return :math:`s.\ELEM-store`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f}).\mathsf{elem} &=& \mathit{s}.\mathsf{elem} &  \\
   \end{array}

.. _def-datainst:


:math:`\datainst-()`
....................


1. Return :math:`s.\DATA-store`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f}).\mathsf{data} &=& \mathit{s}.\mathsf{data} &  \\
   \end{array}

.. _def-func:


:math:`\func-(x)`
.................


1. Let :math:`f` be the current frame.

2. Return :math:`s.\FUNC-store[f.\MODULE-frame.\FUNC-moduleinst[x]]`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {(\mathit{s} ; \mathit{f}).\mathsf{func}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{func}[\mathit{f}.\mathsf{module}.\mathsf{func}[\mathit{x}]] &  \\
   \end{array}

.. _def-global:


:math:`\global-(x)`
...................


1. Let :math:`f` be the current frame.

2. Return :math:`s.\GLOBAL-store[f.\MODULE-frame.\GLOBAL-moduleinst[x]]`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {(\mathit{s} ; \mathit{f}).\mathsf{global}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{global}[\mathit{f}.\mathsf{module}.\mathsf{global}[\mathit{x}]] &  \\
   \end{array}

.. _def-table:


:math:`\table-(x)`
..................


1. Let :math:`f` be the current frame.

2. Return :math:`s.\TABLE-store[f.\MODULE-frame.\TABLE-moduleinst[x]]`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {(\mathit{s} ; \mathit{f}).\mathsf{table}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]] &  \\
   \end{array}

.. _def-mem:


:math:`\mem-(x)`
................


1. Let :math:`f` be the current frame.

2. Return :math:`s.\MEM-store[f.\MODULE-frame.\MEM-moduleinst[x]]`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {(\mathit{s} ; \mathit{f}).\mathsf{mem}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{mem}[\mathit{f}.\mathsf{module}.\mathsf{mem}[\mathit{x}]] &  \\
   \end{array}

.. _def-elem:


:math:`\elem-(x)`
.................


1. Let :math:`f` be the current frame.

2. Return :math:`s.\ELEM-store[f.\MODULE-frame.\ELEM-moduleinst[x]]`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {(\mathit{s} ; \mathit{f}).\mathsf{elem}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{elem}[\mathit{f}.\mathsf{module}.\mathsf{elem}[\mathit{x}]] &  \\
   \end{array}

.. _def-data:


:math:`\data-(x)`
.................


1. Let :math:`f` be the current frame.

2. Return :math:`s.\DATA-store[f.\MODULE-frame.\DATA-moduleinst[x]]`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {(\mathit{s} ; \mathit{f}).\mathsf{data}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{data}[\mathit{f}.\mathsf{module}.\mathsf{data}[\mathit{x}]] &  \\
   \end{array}

.. _def-local:


:math:`\local-(x)`
..................


1. Let :math:`f` be the current frame.

2. Return :math:`f.\LOCAL-frame[x]`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {(\mathit{s} ; \mathit{f}).\mathsf{local}}{[\mathit{x}]} &=& \mathit{f}.\mathsf{local}[\mathit{x}] &  \\
   \end{array}

.. _def-with_local:


:math:`\withlocal-(x, v)`
.........................


1. Let :math:`f` be the current frame.

2. Replace :math:`f.\LOCAL-frame[x]` with :math:`v`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f})[\mathsf{local}[\mathit{x}] = \mathit{v}] &=& \mathit{s} ; \mathit{f}[\mathsf{local}[\mathit{x}] = \mathit{v}] &  \\
   \end{array}

.. _def-with_global:


:math:`\withglobal-(x, v)`
..........................


1. Let :math:`f` be the current frame.

2. Replace :math:`s.\GLOBAL-store[f.\MODULE-frame.\GLOBAL-moduleinst[x]].\VALUE-globalinst` with :math:`v`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f})[\mathsf{global}[\mathit{x}].\mathsf{value} = \mathit{v}] &=& \mathit{s}[\mathsf{global}[\mathit{f}.\mathsf{module}.\mathsf{global}[\mathit{x}]].\mathsf{value} = \mathit{v}] ; \mathit{f} &  \\
   \end{array}

.. _def-with_table:


:math:`\withtable-(x, i, r)`
............................


1. Let :math:`f` be the current frame.

2. Replace :math:`s.\TABLE-store[f.\MODULE-frame.\TABLE-moduleinst[x]].\ELEM-tableinst[i]` with :math:`r`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f})[\mathsf{table}[\mathit{x}].\mathsf{elem}[\mathit{i}] = \mathit{r}] &=& \mathit{s}[\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]].\mathsf{elem}[\mathit{i}] = \mathit{r}] ; \mathit{f} &  \\
   \end{array}

.. _def-with_tableinst:


:math:`\withtableinst-(x, ti)`
..............................


1. Let :math:`f` be the current frame.

2. Replace :math:`s.\TABLE-store[f.\MODULE-frame.\TABLE-moduleinst[x]]` with :math:`ti`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f})[\mathsf{table}[\mathit{x}] = \mathit{ti}] &=& \mathit{s}[\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]] = \mathit{ti}] ; \mathit{f} &  \\
   \end{array}

.. _def-with_mem:


:math:`\withmem-(x, i, j, {b}{^\ast})`
......................................


1. Let :math:`f` be the current frame.

2. Replace :math:`s.\MEM-store[f.\MODULE-frame.\MEM-moduleinst[x]].\DATA-meminst[i : j]` with :math:`{b}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f})[\mathsf{mem}[\mathit{x}].\mathsf{data}[\mathit{i} : \mathit{j}] = {\mathit{b}^\ast}] &=& \mathit{s}[\mathsf{mem}[\mathit{f}.\mathsf{module}.\mathsf{mem}[\mathit{x}]].\mathsf{data}[\mathit{i} : \mathit{j}] = {\mathit{b}^\ast}] ; \mathit{f} &  \\
   \end{array}

.. _def-with_meminst:


:math:`\withmeminst-(x, mi)`
............................


1. Let :math:`f` be the current frame.

2. Replace :math:`s.\MEM-store[f.\MODULE-frame.\MEM-moduleinst[x]]` with :math:`mi`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f})[\mathsf{mem}[\mathit{x}] = \mathit{mi}] &=& \mathit{s}[\mathsf{mem}[\mathit{f}.\mathsf{module}.\mathsf{mem}[\mathit{x}]] = \mathit{mi}] ; \mathit{f} &  \\
   \end{array}

.. _def-with_elem:


:math:`\withelem-(x, {r}{^\ast})`
.................................


1. Let :math:`f` be the current frame.

2. Replace :math:`s.\ELEM-store[f.\MODULE-frame.\ELEM-moduleinst[x]].\ELEM-eleminst` with :math:`{r}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f})[\mathsf{elem}[\mathit{x}].\mathsf{elem} = {\mathit{r}^\ast}] &=& \mathit{s}[\mathsf{elem}[\mathit{f}.\mathsf{module}.\mathsf{elem}[\mathit{x}]].\mathsf{elem} = {\mathit{r}^\ast}] ; \mathit{f} &  \\
   \end{array}

.. _def-with_data:


:math:`\withdata-(x, {b}{^\ast})`
.................................


1. Let :math:`f` be the current frame.

2. Replace :math:`s.\DATA-store[f.\MODULE-frame.\DATA-moduleinst[x]].\DATA-datainst` with :math:`{b}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   (\mathit{s} ; \mathit{f})[\mathsf{data}[\mathit{x}].\mathsf{data} = {\mathit{b}^\ast}] &=& \mathit{s}[\mathsf{data}[\mathit{f}.\mathsf{module}.\mathsf{data}[\mathit{x}]].\mathsf{data} = {\mathit{b}^\ast}] ; \mathit{f} &  \\
   \end{array}

.. _def-grow_table:


:math:`\growtable-(ti, n, r)`
.............................


1. Let :math:`\{\TYPE-tableinst~i~j~rt, \ELEM-tableinst~{r'}{^\ast}\}` be :math:`ti`.

2. Let :math:`i'` be :math:`{|{r'}{^\ast}|} + {n}`.

3. Let :math:`ti'` be :math:`\{\TYPE-tableinst~i'~j~rt, \ELEM-tableinst~{r'}{^\ast}~r^n\}`.

4. If :math:`ti'.\TYPE-tableinst` is valid, then:

   a. Return :math:`ti'`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{grow}_{\mathit{table}}(\mathit{ti},\, \mathit{n},\, \mathit{r}) &=& {\mathit{ti}'} &\quad
     \mbox{if}~\mathit{ti} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{type}~[\mathit{i} .. \mathit{j}]~\mathit{rt},\; \mathsf{elem}~{{\mathit{r}'}^\ast} \}\end{array} \\
    &&&\quad {\land}~{\mathit{i}'} = {|{{\mathit{r}'}^\ast}|} + \mathit{n} \\
    &&&\quad {\land}~{\mathit{ti}'} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{type}~[{\mathit{i}'} .. \mathit{j}]~\mathit{rt},\; \mathsf{elem}~{{\mathit{r}'}^\ast}~{\mathit{r}^{\mathit{n}}} \}\end{array} \\
    &&&\quad {\land}~{ \vdash }\;{\mathit{ti}'}.\mathsf{type} : \mathsf{ok} \\
   \end{array}

.. _def-grow_memory:


:math:`\growmemory-(mi, n)`
...........................


1. Let :math:`\{\TYPE-meminst~\I8-memtype~i~j, \DATA-meminst~{b}{^\ast}\}` be :math:`mi`.

2. Let :math:`i'` be :math:`{{|{b}{^\ast}|} / {{64} \cdot {\Ki-()}}} + {n}`.

3. Let :math:`mi'` be :math:`\{\TYPE-meminst~\I8-memtype~i'~j, \DATA-meminst~{b}{^\ast}~0^{{n} \cdot {64}} \cdot {\Ki-()}\}`.

4. If :math:`mi'.\TYPE-meminst` is valid, then:

   a. Return :math:`mi'`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{grow}_{\mathit{memory}}(\mathit{mi},\, \mathit{n}) &=& {\mathit{mi}'} &\quad
     \mbox{if}~\mathit{mi} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{type}~([\mathit{i} .. \mathit{j}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{\mathit{b}^\ast} \}\end{array} \\
    &&&\quad {\land}~{\mathit{i}'} = {|{\mathit{b}^\ast}|} / (64 \cdot \mathrm{Ki}) + \mathit{n} \\
    &&&\quad {\land}~{\mathit{mi}'} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{type}~([{\mathit{i}'} .. \mathit{j}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{\mathit{b}^\ast}~{0^{\mathit{n} \cdot 64 \cdot \mathrm{Ki}}} \}\end{array} \\
    &&&\quad {\land}~{ \vdash }\;{\mathit{mi}'}.\mathsf{type} : \mathsf{ok} \\
   \end{array}
