.. _exec-modules:

Modules
-------

.. _exec-modules-allocation:

Allocation
~~~~~~~~~~

.. _def-funcs:


:math:`\funcs-({x_{0}}{^\ast})`
...............................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`y_{0}~{externval'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. If :math:`y_{0}` is of the case :math:`\FUNC-externval`, then:

   a. Let :math:`\FUNC-externval~fa` be :math:`y_{0}`.

   b. Return :math:`fa~\funcs-({externval'}{^\ast})`.

4. Let :math:`externval~{externval'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

5. Return :math:`\funcs-({externval'}{^\ast})`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{funcs}(\epsilon) &=& \epsilon &  \\[0.8ex]
   \mathrm{funcs}((\mathsf{func}~\mathit{fa})~{{\mathit{externval}'}^\ast}) &=& \mathit{fa}~\mathrm{funcs}({{\mathit{externval}'}^\ast}) &  \\[0.8ex]
   \mathrm{funcs}(\mathit{externval}~{{\mathit{externval}'}^\ast}) &=& \mathrm{funcs}({{\mathit{externval}'}^\ast}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _def-globals:


:math:`\globals-({x_{0}}{^\ast})`
.................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`y_{0}~{externval'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. If :math:`y_{0}` is of the case :math:`\GLOBAL-externval`, then:

   a. Let :math:`\GLOBAL-externval~ga` be :math:`y_{0}`.

   b. Return :math:`ga~\globals-({externval'}{^\ast})`.

4. Let :math:`externval~{externval'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

5. Return :math:`\globals-({externval'}{^\ast})`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{globals}(\epsilon) &=& \epsilon &  \\[0.8ex]
   \mathrm{globals}((\mathsf{global}~\mathit{ga})~{{\mathit{externval}'}^\ast}) &=& \mathit{ga}~\mathrm{globals}({{\mathit{externval}'}^\ast}) &  \\[0.8ex]
   \mathrm{globals}(\mathit{externval}~{{\mathit{externval}'}^\ast}) &=& \mathrm{globals}({{\mathit{externval}'}^\ast}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _def-tables:


:math:`\tables-({x_{0}}{^\ast})`
................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`y_{0}~{externval'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. If :math:`y_{0}` is of the case :math:`\TABLE-externval`, then:

   a. Let :math:`\TABLE-externval~ta` be :math:`y_{0}`.

   b. Return :math:`ta~\tables-({externval'}{^\ast})`.

4. Let :math:`externval~{externval'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

5. Return :math:`\tables-({externval'}{^\ast})`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{tables}(\epsilon) &=& \epsilon &  \\[0.8ex]
   \mathrm{tables}((\mathsf{table}~\mathit{ta})~{{\mathit{externval}'}^\ast}) &=& \mathit{ta}~\mathrm{tables}({{\mathit{externval}'}^\ast}) &  \\[0.8ex]
   \mathrm{tables}(\mathit{externval}~{{\mathit{externval}'}^\ast}) &=& \mathrm{tables}({{\mathit{externval}'}^\ast}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _def-mems:


:math:`\mems-({x_{0}}{^\ast})`
..............................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`y_{0}~{externval'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. If :math:`y_{0}` is of the case :math:`\MEM-externval`, then:

   a. Let :math:`\MEM-externval~ma` be :math:`y_{0}`.

   b. Return :math:`ma~\mems-({externval'}{^\ast})`.

4. Let :math:`externval~{externval'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

5. Return :math:`\mems-({externval'}{^\ast})`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{mems}(\epsilon) &=& \epsilon &  \\[0.8ex]
   \mathrm{mems}((\mathsf{mem}~\mathit{ma})~{{\mathit{externval}'}^\ast}) &=& \mathit{ma}~\mathrm{mems}({{\mathit{externval}'}^\ast}) &  \\[0.8ex]
   \mathrm{mems}(\mathit{externval}~{{\mathit{externval}'}^\ast}) &=& \mathrm{mems}({{\mathit{externval}'}^\ast}) &\quad
     \mbox{otherwise} \\
   \end{array}

.. _def-allocfunc:


:math:`\allocfunc-(m, func)`
............................


1. Let :math:`fi` be :math:`\{\MODULE-funcinst~m, \CODE-funcinst~func\}`.

2. Return :math:`s~\bigoplus~\{.\FUNC-store~fi\}~|s.\FUNC-store|`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocfunc}(\mathit{s},\, \mathit{m},\, \mathit{func}) &=& (\mathit{s}[\mathsf{func} = ..\mathit{fi}],\, {|\mathit{s}.\mathsf{func}|}) &\quad
     \mbox{if}~\mathit{fi} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{module}~\mathit{m},\; \mathsf{code}~\mathit{func} \}\end{array} \\
   \end{array}

.. _def-allocfuncs:


:math:`\allocfuncs-(m, {x_{0}}{^\ast})`
.......................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`func~{func'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. Let :math:`fa` be :math:`\allocfunc-(m, func)`.

4. Let :math:`{fa'}{^\ast}` be :math:`\allocfuncs-(m, {func'}{^\ast})`.

5. Return :math:`fa~{fa'}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocfuncs}(\mathit{s},\, \mathit{m},\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\[0.8ex]
   \mathrm{allocfuncs}(\mathit{s},\, \mathit{m},\, \mathit{func}~{{\mathit{func}'}^\ast}) &=& (\mathit{s}_{2},\, \mathit{fa}~{{\mathit{fa}'}^\ast}) &\quad
     \mbox{if}~(\mathit{s}_{1},\, \mathit{fa}) = \mathrm{allocfunc}(\mathit{s},\, \mathit{m},\, \mathit{func}) \\
    &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{fa}'}^\ast}) = \mathrm{allocfuncs}(\mathit{s}_{1},\, \mathit{m},\, {{\mathit{func}'}^\ast}) \\
   \end{array}

.. _def-allocglobal:


:math:`\allocglobal-(globaltype, val)`
......................................


1. Let :math:`gi` be :math:`\{\TYPE-globalinst~globaltype, \VALUE-globalinst~val\}`.

2. Return :math:`s~\bigoplus~\{.\GLOBAL-store~gi\}~|s.\GLOBAL-store|`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocglobal}(\mathit{s},\, \mathit{globaltype},\, \mathit{val}) &=& (\mathit{s}[\mathsf{global} = ..\mathit{gi}],\, {|\mathit{s}.\mathsf{global}|}) &\quad
     \mbox{if}~\mathit{gi} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{type}~\mathit{globaltype},\; \mathsf{value}~\mathit{val} \}\end{array} \\
   \end{array}

.. _def-allocglobals:


:math:`\allocglobals-({x_{0}}{^\ast}, {x_{1}}{^\ast})`
......................................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Assert: Due to validation, :math:`{x_{1}}{^\ast}` is :math:`\epsilon`.

   b. Return :math:`\epsilon`.

2. Else:

   a. Let :math:`globaltype~{globaltype'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

   b. Assert: Due to validation, the length of :math:`{x_{1}}{^\ast}` is greater than or equal to :math:`1`.

   c. Let :math:`val~{val'}{^\ast}` be :math:`{x_{1}}{^\ast}`.

   d. Let :math:`ga` be :math:`\allocglobal-(globaltype, val)`.

   e. Let :math:`{ga'}{^\ast}` be :math:`\allocglobals-({globaltype'}{^\ast}, {val'}{^\ast})`.

   f. Return :math:`ga~{ga'}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocglobals}(\mathit{s},\, \epsilon,\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\[0.8ex]
   \mathrm{allocglobals}(\mathit{s},\, \mathit{globaltype}~{{\mathit{globaltype}'}^\ast},\, \mathit{val}~{{\mathit{val}'}^\ast}) &=& (\mathit{s}_{2},\, \mathit{ga}~{{\mathit{ga}'}^\ast}) &\quad
     \mbox{if}~(\mathit{s}_{1},\, \mathit{ga}) = \mathrm{allocglobal}(\mathit{s},\, \mathit{globaltype},\, \mathit{val}) \\
    &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{ga}'}^\ast}) = \mathrm{allocglobals}(\mathit{s}_{1},\, {{\mathit{globaltype}'}^\ast},\, {{\mathit{val}'}^\ast}) \\
   \end{array}

.. _def-alloctable:


:math:`\alloctable-(i~j~rt)`
............................


1. Let :math:`ti` be :math:`\{\TYPE-tableinst~i~j~rt, \ELEM-tableinst~\REFNULL-ref~rt^i\}`.

2. Return :math:`s~\bigoplus~\{.\TABLE-store~ti\}~|s.\TABLE-store|`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{alloctable}(\mathit{s},\, [\mathit{i} .. \mathit{j}]~\mathit{rt}) &=& (\mathit{s}[\mathsf{table} = ..\mathit{ti}],\, {|\mathit{s}.\mathsf{table}|}) &\quad
     \mbox{if}~\mathit{ti} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{type}~([\mathit{i} .. \mathit{j}]~\mathit{rt}),\; \mathsf{elem}~{(\mathsf{ref.null}~\mathit{rt})^{\mathit{i}}} \}\end{array} \\
   \end{array}

.. _def-alloctables:


:math:`\alloctables-({x_{0}}{^\ast})`
.....................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`tabletype~{tabletype'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. Let :math:`ta` be :math:`\alloctable-(tabletype)`.

4. Let :math:`{ta'}{^\ast}` be :math:`\alloctables-({tabletype'}{^\ast})`.

5. Return :math:`ta~{ta'}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{alloctables}(\mathit{s},\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\[0.8ex]
   \mathrm{alloctables}(\mathit{s},\, \mathit{tabletype}~{{\mathit{tabletype}'}^\ast}) &=& (\mathit{s}_{2},\, \mathit{ta}~{{\mathit{ta}'}^\ast}) &\quad
     \mbox{if}~(\mathit{s}_{1},\, \mathit{ta}) = \mathrm{alloctable}(\mathit{s},\, \mathit{tabletype}) \\
    &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{ta}'}^\ast}) = \mathrm{alloctables}(\mathit{s}_{1},\, {{\mathit{tabletype}'}^\ast}) \\
   \end{array}

.. _def-allocmem:


:math:`\allocmem-(\I8-memtype~i~j)`
...................................


1. Let :math:`mi` be :math:`\{\TYPE-meminst~\I8-memtype~i~j, \DATA-meminst~0^{{i} \cdot {64}} \cdot {\Ki-()}\}`.

2. Return :math:`s~\bigoplus~\{.\MEM-store~mi\}~|s.\MEM-store|`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocmem}(\mathit{s},\, [\mathit{i} .. \mathit{j}]~\mathsf{i{\scriptstyle8}}) &=& (\mathit{s}[\mathsf{mem} = ..\mathit{mi}],\, {|\mathit{s}.\mathsf{mem}|}) &\quad
     \mbox{if}~\mathit{mi} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{type}~([\mathit{i} .. \mathit{j}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{0^{\mathit{i} \cdot 64 \cdot \mathrm{Ki}}} \}\end{array} \\
   \end{array}

.. _def-allocmems:


:math:`\allocmems-({x_{0}}{^\ast})`
...................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`memtype~{memtype'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. Let :math:`ma` be :math:`\allocmem-(memtype)`.

4. Let :math:`{ma'}{^\ast}` be :math:`\allocmems-({memtype'}{^\ast})`.

5. Return :math:`ma~{ma'}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocmems}(\mathit{s},\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\[0.8ex]
   \mathrm{allocmems}(\mathit{s},\, \mathit{memtype}~{{\mathit{memtype}'}^\ast}) &=& (\mathit{s}_{2},\, \mathit{ma}~{{\mathit{ma}'}^\ast}) &\quad
     \mbox{if}~(\mathit{s}_{1},\, \mathit{ma}) = \mathrm{allocmem}(\mathit{s},\, \mathit{memtype}) \\
    &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{ma}'}^\ast}) = \mathrm{allocmems}(\mathit{s}_{1},\, {{\mathit{memtype}'}^\ast}) \\
   \end{array}

.. _def-allocelem:


:math:`\allocelem-(rt, {ref}{^\ast})`
.....................................


1. Let :math:`ei` be :math:`\{\TYPE-eleminst~rt, \ELEM-eleminst~{ref}{^\ast}\}`.

2. Return :math:`s~\bigoplus~\{.\ELEM-store~ei\}~|s.\ELEM-store|`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocelem}(\mathit{s},\, \mathit{rt},\, {\mathit{ref}^\ast}) &=& (\mathit{s}[\mathsf{elem} = ..\mathit{ei}],\, {|\mathit{s}.\mathsf{elem}|}) &\quad
     \mbox{if}~\mathit{ei} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{type}~\mathit{rt},\; \mathsf{elem}~{\mathit{ref}^\ast} \}\end{array} \\
   \end{array}

.. _def-allocelems:


:math:`\allocelems-({x_{0}}{^\ast}, {x_{1}}{^\ast})`
....................................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon` and :math:`{x_{1}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Assert: Due to validation, the length of :math:`{x_{1}}{^\ast}` is greater than or equal to :math:`1`.

3. Let :math:`{ref}{^\ast}~{({ref'}{^\ast})}{^\ast}` be :math:`{x_{1}}{^\ast}`.

4. Assert: Due to validation, the length of :math:`{x_{0}}{^\ast}` is greater than or equal to :math:`1`.

5. Let :math:`rt~{rt'}{^\ast}` be :math:`{x_{0}}{^\ast}`.

6. Let :math:`ea` be :math:`\allocelem-(rt, {ref}{^\ast})`.

7. Let :math:`{ea'}{^\ast}` be :math:`\allocelems-({rt'}{^\ast}, {({ref'}{^\ast})}{^\ast})`.

8. Return :math:`ea~{ea'}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocelems}(\mathit{s},\, \epsilon,\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\[0.8ex]
   \mathrm{allocelems}(\mathit{s},\, \mathit{rt}~{{\mathit{rt}'}^\ast},\, ({\mathit{ref}^\ast})~{({{\mathit{ref}'}^\ast})^\ast}) &=& (\mathit{s}_{2},\, \mathit{ea}~{{\mathit{ea}'}^\ast}) &\quad
     \mbox{if}~(\mathit{s}_{1},\, \mathit{ea}) = \mathrm{allocelem}(\mathit{s},\, \mathit{rt},\, {\mathit{ref}^\ast}) \\
    &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{ea}'}^\ast}) = \mathrm{allocelems}(\mathit{s}_{2},\, {{\mathit{rt}'}^\ast},\, {({{\mathit{ref}'}^\ast})^\ast}) \\
   \end{array}

.. _def-allocdata:


:math:`\allocdata-({byte}{^\ast})`
..................................


1. Let :math:`di` be :math:`\{\DATA-datainst~{byte}{^\ast}\}`.

2. Return :math:`s~\bigoplus~\{.\DATA-store~di\}~|s.\DATA-store|`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocdata}(\mathit{s},\, {\mathit{byte}^\ast}) &=& (\mathit{s}[\mathsf{data} = ..\mathit{di}],\, {|\mathit{s}.\mathsf{data}|}) &\quad
     \mbox{if}~\mathit{di} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{data}~{\mathit{byte}^\ast} \}\end{array} \\
   \end{array}

.. _def-allocdatas:


:math:`\allocdatas-({x_{0}}{^\ast})`
....................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`{byte}{^\ast}~{({byte'}{^\ast})}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. Let :math:`da` be :math:`\allocdata-({byte}{^\ast})`.

4. Let :math:`{da'}{^\ast}` be :math:`\allocdatas-({({byte'}{^\ast})}{^\ast})`.

5. Return :math:`da~{da'}{^\ast}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocdatas}(\mathit{s},\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\[0.8ex]
   \mathrm{allocdatas}(\mathit{s},\, ({\mathit{byte}^\ast})~{({{\mathit{byte}'}^\ast})^\ast}) &=& (\mathit{s}_{2},\, \mathit{da}~{{\mathit{da}'}^\ast}) &\quad
     \mbox{if}~(\mathit{s}_{1},\, \mathit{da}) = \mathrm{allocdata}(\mathit{s},\, {\mathit{byte}^\ast}) \\
    &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{da}'}^\ast}) = \mathrm{allocdatas}(\mathit{s}_{1},\, {({{\mathit{byte}'}^\ast})^\ast}) \\
   \end{array}

.. _def-instexport:


:math:`\instexport-({fa}{^\ast}, {ga}{^\ast}, {ta}{^\ast}, {ma}{^\ast}, \EXPORT-export~name~x_{0})`
...................................................................................................


1. If :math:`x_{0}` is of the case :math:`\FUNC-externuse`, then:

   a. Let :math:`\FUNC-externuse~x` be :math:`x_{0}`.

   b. Return :math:`\{\NAME-exportinst~name, \VALUE-exportinst~\FUNC-externval~{fa}{^\ast}[x]\}`.

2. If :math:`x_{0}` is of the case :math:`\GLOBAL-externuse`, then:

   a. Let :math:`\GLOBAL-externuse~x` be :math:`x_{0}`.

   b. Return :math:`\{\NAME-exportinst~name, \VALUE-exportinst~\GLOBAL-externval~{ga}{^\ast}[x]\}`.

3. If :math:`x_{0}` is of the case :math:`\TABLE-externuse`, then:

   a. Let :math:`\TABLE-externuse~x` be :math:`x_{0}`.

   b. Return :math:`\{\NAME-exportinst~name, \VALUE-exportinst~\TABLE-externval~{ta}{^\ast}[x]\}`.

4. Assert: Due to validation, :math:`x_{0}` is of the case :math:`\MEM-externuse`.

5. Let :math:`\MEM-externuse~x` be :math:`x_{0}`.

6. Return :math:`\{\NAME-exportinst~name, \VALUE-exportinst~\MEM-externval~{ma}{^\ast}[x]\}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{instexport}({\mathit{fa}^\ast},\, {\mathit{ga}^\ast},\, {\mathit{ta}^\ast},\, {\mathit{ma}^\ast},\, \mathsf{export}~\mathit{name}~(\mathsf{func}~\mathit{x})) &=& \{ \begin{array}[t]{@{}l@{}}
   \mathsf{name}~\mathit{name},\; \mathsf{value}~(\mathsf{func}~{\mathit{fa}^\ast}[\mathit{x}]) \}\end{array} &  \\[0.8ex]
   \mathrm{instexport}({\mathit{fa}^\ast},\, {\mathit{ga}^\ast},\, {\mathit{ta}^\ast},\, {\mathit{ma}^\ast},\, \mathsf{export}~\mathit{name}~(\mathsf{global}~\mathit{x})) &=& \{ \begin{array}[t]{@{}l@{}}
   \mathsf{name}~\mathit{name},\; \mathsf{value}~(\mathsf{global}~{\mathit{ga}^\ast}[\mathit{x}]) \}\end{array} &  \\[0.8ex]
   \mathrm{instexport}({\mathit{fa}^\ast},\, {\mathit{ga}^\ast},\, {\mathit{ta}^\ast},\, {\mathit{ma}^\ast},\, \mathsf{export}~\mathit{name}~(\mathsf{table}~\mathit{x})) &=& \{ \begin{array}[t]{@{}l@{}}
   \mathsf{name}~\mathit{name},\; \mathsf{value}~(\mathsf{table}~{\mathit{ta}^\ast}[\mathit{x}]) \}\end{array} &  \\[0.8ex]
   \mathrm{instexport}({\mathit{fa}^\ast},\, {\mathit{ga}^\ast},\, {\mathit{ta}^\ast},\, {\mathit{ma}^\ast},\, \mathsf{export}~\mathit{name}~(\mathsf{mem}~\mathit{x})) &=& \{ \begin{array}[t]{@{}l@{}}
   \mathsf{name}~\mathit{name},\; \mathsf{value}~(\mathsf{mem}~{\mathit{ma}^\ast}[\mathit{x}]) \}\end{array} &  \\
   \end{array}

.. _def-allocmodule:


:math:`\allocmodule-(module, {externval}{^\ast}, {val}{^\ast}, {({ref}{^\ast})}{^\ast})`
........................................................................................


1. Let :math:`{fa_{ex}}{^\ast}` be :math:`\funcs-({externval}{^\ast})`.

2. Let :math:`{ga_{ex}}{^\ast}` be :math:`\globals-({externval}{^\ast})`.

3. Let :math:`{ma_{ex}}{^\ast}` be :math:`\mems-({externval}{^\ast})`.

4. Let :math:`{ta_{ex}}{^\ast}` be :math:`\tables-({externval}{^\ast})`.

5. Assert: Due to validation, :math:`module` is of the case :math:`\MODULE-module`.

6. Let :math:`\MODULE-module~{import}{^\ast}~{func}{^{n_{func}}}~y_{0}~y_{1}~y_{2}~y_{3}~y_{4}~{start}{^?}~{export}{^\ast}` be :math:`module`.

7. Let :math:`{(\DATA-data~{byte}{^\ast}~{datamode}{^?})}{^{n_{data}}}` be :math:`y_{4}`.

8. Let :math:`{(\ELEM-elem~rt~{expr_{2}}{^\ast}~{elemmode}{^?})}{^{n_{elem}}}` be :math:`y_{3}`.

9. Let :math:`{(\MEMORY-mem~memtype)}{^{n_{mem}}}` be :math:`y_{2}`.

10. Let :math:`{(\TABLE-table~tabletype)}{^{n_{table}}}` be :math:`y_{1}`.

11. Let :math:`{(\GLOBAL-global~globaltype~expr_{1})}{^{n_{global}}}` be :math:`y_{0}`.

12. Let :math:`{da}{^\ast}` be :math:`{({|s.\DATA-store|} + {i_{data}})}{^{(i_{data}<n_{data})}}`.

13. Let :math:`{ea}{^\ast}` be :math:`{({|s.\ELEM-store|} + {i_{elem}})}{^{(i_{elem}<n_{elem})}}`.

14. Let :math:`{ma}{^\ast}` be :math:`{({|s.\MEM-store|} + {i_{mem}})}{^{(i_{mem}<n_{mem})}}`.

15. Let :math:`{ta}{^\ast}` be :math:`{({|s.\TABLE-store|} + {i_{table}})}{^{(i_{table}<n_{table})}}`.

16. Let :math:`{ga}{^\ast}` be :math:`{({|s.\GLOBAL-store|} + {i_{global}})}{^{(i_{global}<n_{global})}}`.

17. Let :math:`{fa}{^\ast}` be :math:`{({|s.\FUNC-store|} + {i_{func}})}{^{(i_{func}<n_{func})}}`.

18. Let :math:`{xi}{^\ast}` be :math:`{(\instexport-({fa_{ex}}{^\ast}~{fa}{^\ast}, {ga_{ex}}{^\ast}~{ga}{^\ast}, {ta_{ex}}{^\ast}~{ta}{^\ast}, {ma_{ex}}{^\ast}~{ma}{^\ast}, export))}{^\ast}`.

19. Let :math:`m` be :math:`\{\FUNC-moduleinst~{fa_{ex}}{^\ast}~{fa}{^\ast}, \GLOBAL-moduleinst~{ga_{ex}}{^\ast}~{ga}{^\ast}, \TABLE-moduleinst~{ta_{ex}}{^\ast}~{ta}{^\ast}, \MEM-moduleinst~{ma_{ex}}{^\ast}~{ma}{^\ast}, \ELEM-moduleinst~{ea}{^\ast}, \DATA-moduleinst~{da}{^\ast}, \EXPORT-moduleinst~{xi}{^\ast}\}`.

20. Let :math:`y_{0}` be :math:`\allocfuncs-(m, {func}{^{n_{func}}})`.

21. Assert: Due to validation, :math:`y_{0}` is :math:`{fa}{^\ast}`.

22. Let :math:`y_{0}` be :math:`\allocglobals-({globaltype}{^{n_{global}}}, {val}{^\ast})`.

23. Assert: Due to validation, :math:`y_{0}` is :math:`{ga}{^\ast}`.

24. Let :math:`y_{0}` be :math:`\alloctables-({tabletype}{^{n_{table}}})`.

25. Assert: Due to validation, :math:`y_{0}` is :math:`{ta}{^\ast}`.

26. Let :math:`y_{0}` be :math:`\allocmems-({memtype}{^{n_{mem}}})`.

27. Assert: Due to validation, :math:`y_{0}` is :math:`{ma}{^\ast}`.

28. Let :math:`y_{0}` be :math:`\allocelems-({rt}{^{n_{elem}}}, {({ref}{^\ast})}{^\ast})`.

29. Assert: Due to validation, :math:`y_{0}` is :math:`{ea}{^\ast}`.

30. Let :math:`y_{0}` be :math:`\allocdatas-({({byte}{^\ast})}{^{n_{data}}})`.

31. Assert: Due to validation, :math:`y_{0}` is :math:`{da}{^\ast}`.

32. Return :math:`m`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{allocmodule}(\mathit{s},\, \mathit{module},\, {\mathit{externval}^\ast},\, {\mathit{val}^\ast},\, {({\mathit{ref}^\ast})^\ast}) &=& (\mathit{s}_{6},\, \mathit{m}) &\quad
     \mbox{if}~\mathit{module} = \mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^{\mathit{n}_{\mathit{func}}}}~{(\mathsf{global}~\mathit{globaltype}~\mathit{expr}_{1})^{\mathit{n}_{\mathit{global}}}}~{(\mathsf{table}~\mathit{tabletype})^{\mathit{n}_{\mathit{table}}}}~{(\mathsf{memory}~\mathit{memtype})^{\mathit{n}_{\mathit{mem}}}}~{(\mathsf{elem}~\mathit{rt}~{\mathit{expr}_{2}^\ast}~{\mathit{elemmode}^?})^{\mathit{n}_{\mathit{elem}}}}~{(\mathsf{data}~{\mathit{byte}^\ast}~{\mathit{datamode}^?})^{\mathit{n}_{\mathit{data}}}}~{\mathit{start}^?}~{\mathit{export}^\ast} \\
    &&&\quad {\land}~{\mathit{fa}_{\mathit{ex}}^\ast} = \mathrm{funcs}({\mathit{externval}^\ast}) \\
    &&&\quad {\land}~{\mathit{ga}_{\mathit{ex}}^\ast} = \mathrm{globals}({\mathit{externval}^\ast}) \\
    &&&\quad {\land}~{\mathit{ta}_{\mathit{ex}}^\ast} = \mathrm{tables}({\mathit{externval}^\ast}) \\
    &&&\quad {\land}~{\mathit{ma}_{\mathit{ex}}^\ast} = \mathrm{mems}({\mathit{externval}^\ast}) \\
    &&&\quad {\land}~{\mathit{fa}^\ast} = {{|\mathit{s}.\mathsf{func}|} + \mathit{i}_{\mathit{func}}^(i_func<\mathit{n}_{\mathit{func}})} \\
    &&&\quad {\land}~{\mathit{ga}^\ast} = {{|\mathit{s}.\mathsf{global}|} + \mathit{i}_{\mathit{global}}^(i_global<\mathit{n}_{\mathit{global}})} \\
    &&&\quad {\land}~{\mathit{ta}^\ast} = {{|\mathit{s}.\mathsf{table}|} + \mathit{i}_{\mathit{table}}^(i_table<\mathit{n}_{\mathit{table}})} \\
    &&&\quad {\land}~{\mathit{ma}^\ast} = {{|\mathit{s}.\mathsf{mem}|} + \mathit{i}_{\mathit{mem}}^(i_mem<\mathit{n}_{\mathit{mem}})} \\
    &&&\quad {\land}~{\mathit{ea}^\ast} = {{|\mathit{s}.\mathsf{elem}|} + \mathit{i}_{\mathit{elem}}^(i_elem<\mathit{n}_{\mathit{elem}})} \\
    &&&\quad {\land}~{\mathit{da}^\ast} = {{|\mathit{s}.\mathsf{data}|} + \mathit{i}_{\mathit{data}}^(i_data<\mathit{n}_{\mathit{data}})} \\
    &&&\quad {\land}~{\mathit{xi}^\ast} = {\mathrm{instexport}({\mathit{fa}_{\mathit{ex}}^\ast}~{\mathit{fa}^\ast},\, {\mathit{ga}_{\mathit{ex}}^\ast}~{\mathit{ga}^\ast},\, {\mathit{ta}_{\mathit{ex}}^\ast}~{\mathit{ta}^\ast},\, {\mathit{ma}_{\mathit{ex}}^\ast}~{\mathit{ma}^\ast},\, \mathit{export})^\ast} \\
    &&&\quad {\land}~\mathit{m} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{func}~{\mathit{fa}_{\mathit{ex}}^\ast}~{\mathit{fa}^\ast},\; \\
     \mathsf{global}~{\mathit{ga}_{\mathit{ex}}^\ast}~{\mathit{ga}^\ast},\; \\
     \mathsf{table}~{\mathit{ta}_{\mathit{ex}}^\ast}~{\mathit{ta}^\ast},\; \\
     \mathsf{mem}~{\mathit{ma}_{\mathit{ex}}^\ast}~{\mathit{ma}^\ast},\; \\
     \mathsf{elem}~{\mathit{ea}^\ast},\; \\
     \mathsf{data}~{\mathit{da}^\ast},\; \\
     \mathsf{export}~{\mathit{xi}^\ast} \}\end{array} \\
    &&&\quad {\land}~(\mathit{s}_{1},\, {\mathit{fa}^\ast}) = \mathrm{allocfuncs}(\mathit{s},\, \mathit{m},\, {\mathit{func}^{\mathit{n}_{\mathit{func}}}}) \\
    &&&\quad {\land}~(\mathit{s}_{2},\, {\mathit{ga}^\ast}) = \mathrm{allocglobals}(\mathit{s}_{1},\, {\mathit{globaltype}^{\mathit{n}_{\mathit{global}}}},\, {\mathit{val}^\ast}) \\
    &&&\quad {\land}~(\mathit{s}_{3},\, {\mathit{ta}^\ast}) = \mathrm{alloctables}(\mathit{s}_{2},\, {\mathit{tabletype}^{\mathit{n}_{\mathit{table}}}}) \\
    &&&\quad {\land}~(\mathit{s}_{4},\, {\mathit{ma}^\ast}) = \mathrm{allocmems}(\mathit{s}_{3},\, {\mathit{memtype}^{\mathit{n}_{\mathit{mem}}}}) \\
    &&&\quad {\land}~(\mathit{s}_{5},\, {\mathit{ea}^\ast}) = \mathrm{allocelems}(\mathit{s}_{4},\, {\mathit{rt}^{\mathit{n}_{\mathit{elem}}}},\, {({\mathit{ref}^\ast})^\ast}) \\
    &&&\quad {\land}~(\mathit{s}_{6},\, {\mathit{da}^\ast}) = \mathrm{allocdatas}(\mathit{s}_{5},\, {({\mathit{byte}^\ast})^{\mathit{n}_{\mathit{data}}}}) \\
   \end{array}

.. _exec-modules-instantiation:

Instantiation
~~~~~~~~~~~~~

.. _def-concat_instr:


:math:`\concatinstr-({x_{0}}{^\ast})`
.....................................


1. If :math:`{x_{0}}{^\ast}` is :math:`\epsilon`, then:

   a. Return :math:`\epsilon`.

2. Let :math:`{instr}{^\ast}~{({instr'}{^\ast})}{^\ast}` be :math:`{x_{0}}{^\ast}`.

3. Return :math:`{instr}{^\ast}~\concatinstr-({({instr'}{^\ast})}{^\ast})`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{concat}_{\mathit{instr}}(\epsilon) &=& \epsilon &  \\[0.8ex]
   \mathrm{concat}_{\mathit{instr}}(({\mathit{instr}^\ast})~{({{\mathit{instr}'}^\ast})^\ast}) &=& {\mathit{instr}^\ast}~\mathrm{concat}_{\mathit{instr}}({({{\mathit{instr}'}^\ast})^\ast}) &  \\
   \end{array}

.. _def-instantiation:



:math:`\instantiation-(module, {externval}{^\ast})`
...................................................


1. Assert: Due to validation, :math:`module` is of the case :math:`\MODULE-module`.

2. Let :math:`\MODULE-module~{import}{^\ast}~{func}{^{n_{func}}}~{global}{^\ast}~{table}{^\ast}~{mem}{^\ast}~{elem}{^\ast}~{data}{^\ast}~{start}{^?}~{export}{^\ast}` be :math:`module`.

3. Let :math:`m_{init}` be :math:`\{\FUNC-moduleinst~\funcs-({externval}{^\ast})~{({|s.\FUNC-store|} + {i_{func}})}{^{(i_{func}<n_{func})}}, \GLOBAL-moduleinst~\globals-({externval}{^\ast}), \TABLE-moduleinst~\epsilon, \MEM-moduleinst~\epsilon, \ELEM-moduleinst~\epsilon, \DATA-moduleinst~\epsilon, \EXPORT-moduleinst~\epsilon\}`.

4. Let :math:`n_{data}` be the length of :math:`{data}{^\ast}`.

5. Let :math:`n_{elem}` be the length of :math:`{elem}{^\ast}`.

6. Let :math:`{(\START-start~x)}{^?}` be :math:`{start}{^?}`.

7. Let :math:`{(\GLOBAL-global~globaltype~{instr_{1}}{^\ast})}{^\ast}` be :math:`{global}{^\ast}`.

8. Let :math:`{(\ELEM-elem~reftype~{({instr_{2}}{^\ast})}{^\ast}~{elemmode}{^?})}{^\ast}` be :math:`{elem}{^\ast}`.

9. Let :math:`f_{init}` be :math:`\{\LOCAL-frame~\epsilon, \MODULE-frame~m_{init}\}`.

10. Let :math:`{instr_{data}}{^\ast}` be :math:`\concatinstr-({(\rundata-({data}{^\ast}[j], j))}{^{(j<n_{data})}})`.

11. Let :math:`{instr_{elem}}{^\ast}` be :math:`\concatinstr-({(\runelem-({elem}{^\ast}[i], i))}{^{(i<n_{elem})}})`.

12. Push the activation of :math:`f_{init}` to the stack.

13. Let :math:`{({ref}{^\ast})}{^\ast}` be :math:`{({(exec\_expr\_const({instr_{2}}{^\ast}))}{^\ast})}{^\ast}`.

14. Pop the activation of :math:`f_{init}` from the stack.

15. Push the activation of :math:`f_{init}` to the stack.

16. Let :math:`{val}{^\ast}` be :math:`{(exec\_expr\_const({instr_{1}}{^\ast}))}{^\ast}`.

17. Pop the activation of :math:`f_{init}` from the stack.

18. Let :math:`m` be :math:`\allocmodule-(module, {externval}{^\ast}, {val}{^\ast}, {({ref}{^\ast})}{^\ast})`.

19. Let :math:`f` be :math:`\{\LOCAL-frame~\epsilon, \MODULE-frame~m\}`.

20. Push the activation of :math:`f` to the stack.

21. Execute the sequence :math:`{instr_{elem}}{^\ast}`.

22. Execute the sequence :math:`{instr_{data}}{^\ast}`.

23. If :math:`x` is defined, then:

   a. Let :math:`{x_{0}}^?` be :math:`x`.

   b. Execute :math:`\CALL-instr-control~x_{0}`.

24. Pop the activation of :math:`f` from the stack.

25. Return :math:`m`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{instantiation}(\mathit{s},\, \mathit{module},\, {\mathit{externval}^\ast}) &=& {\mathit{s}'} ; \mathit{f} ; {\mathit{instr}_{\mathit{elem}}^\ast}~{\mathit{instr}_{\mathit{data}}^\ast}~{(\mathsf{call}~\mathit{x})^?} &\quad
     \mbox{if}~\mathit{module} = \mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^{\mathit{n}_{\mathit{func}}}}~{\mathit{global}^\ast}~{\mathit{table}^\ast}~{\mathit{mem}^\ast}~{\mathit{elem}^\ast}~{\mathit{data}^\ast}~{\mathit{start}^?}~{\mathit{export}^\ast} \\
    &&&\quad {\land}~\mathit{m}_{\mathit{init}} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{func}~\mathrm{funcs}({\mathit{externval}^\ast})~{{|\mathit{s}.\mathsf{func}|} + \mathit{i}_{\mathit{func}}^(i_func<\mathit{n}_{\mathit{func}})},\; \\
     \mathsf{global}~\mathrm{globals}({\mathit{externval}^\ast}),\; \\
     \mathsf{table}~\epsilon,\; \\
     \mathsf{mem}~\epsilon,\; \\
     \mathsf{elem}~\epsilon,\; \\
     \mathsf{data}~\epsilon,\; \\
     \mathsf{export}~\epsilon \}\end{array} \\
    &&&\quad {\land}~\mathit{f}_{\mathit{init}} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{local}~\epsilon,\; \mathsf{module}~\mathit{m}_{\mathit{init}} \}\end{array} \\
    &&&\quad {\land}~{\mathit{global}^\ast} = {(\mathsf{global}~\mathit{globaltype}~{\mathit{instr}_{1}^\ast})^\ast} \\
    &&&\quad {\land}~(\mathit{s} ; \mathit{f}_{\mathit{init}} ; {\mathit{instr}_{1}^\ast} \hookrightarrow \mathit{val})^\ast \\
    &&&\quad {\land}~{\mathit{elem}^\ast} = {(\mathsf{elem}~\mathit{reftype}~{({\mathit{instr}_{2}^\ast})^\ast}~{\mathit{elemmode}^?})^\ast} \\
    &&&\quad {\land}~{(\mathit{s} ; \mathit{f}_{\mathit{init}} ; {\mathit{instr}_{2}^\ast} \hookrightarrow \mathit{ref})^\ast}^\ast \\
    &&&\quad {\land}~({\mathit{s}'},\, \mathit{m}) = \mathrm{allocmodule}(\mathit{s},\, \mathit{module},\, {\mathit{externval}^\ast},\, {\mathit{val}^\ast},\, {({\mathit{ref}^\ast})^\ast}) \\
    &&&\quad {\land}~\mathit{f} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{local}~\epsilon,\; \mathsf{module}~\mathit{m} \}\end{array} \\
    &&&\quad {\land}~\mathit{n}_{\mathit{elem}} = {|{\mathit{elem}^\ast}|} \\
    &&&\quad {\land}~{\mathit{instr}_{\mathit{elem}}^\ast} = \mathrm{concat}_{\mathit{instr}}({\mathrm{runelem}({\mathit{elem}^\ast}[\mathit{i}],\, \mathit{i})^(i<\mathit{n}_{\mathit{elem}})}) \\
    &&&\quad {\land}~\mathit{n}_{\mathit{data}} = {|{\mathit{data}^\ast}|} \\
    &&&\quad {\land}~{\mathit{instr}_{\mathit{data}}^\ast} = \mathrm{concat}_{\mathit{instr}}({\mathrm{rundata}({\mathit{data}^\ast}[\mathit{j}],\, \mathit{j})^(j<\mathit{n}_{\mathit{data}})}) \\
    &&&\quad {\land}~{\mathit{start}^?} = {(\mathsf{start}~\mathit{x})^?} \\
   \end{array}

.. _exec-modules-invocation:

Invocation
~~~~~~~~~~

.. _def-invocation:


:math:`\invocation-(fa, {val}{^{n}})`
.....................................


1. Let :math:`m` be :math:`\{\FUNC-moduleinst~\epsilon, \GLOBAL-moduleinst~\epsilon, \TABLE-moduleinst~\epsilon, \MEM-moduleinst~\epsilon, \ELEM-moduleinst~\epsilon, \DATA-moduleinst~\epsilon, \EXPORT-moduleinst~\epsilon\}`.

2. Let :math:`f` be :math:`\{\LOCAL-frame~\epsilon, \MODULE-frame~m\}`.

3. Assert: Due to validation, :math:`\funcinst-()[fa].\CODE-funcinst` is of the case :math:`\FUNC-func`.

4. Let :math:`\FUNC-func~functype~{valtype}{^\ast}~expr` be :math:`\funcinst-()[fa].\CODE-funcinst`.

5. Let :math:`{valtype_{param}}{^{n}} \to {valtype_{res}}{^{k}}` be :math:`functype`.

6. Push the activation of :math:`f` to the stack.

7. Push :math:`{val}{^{n}}` to the stack.

8. Execute :math:`\CALLADDR-admininstr~fa`.

9. Pop :math:`{val}{^{k}}` from the stack.

10. Pop the activation of :math:`f` from the stack.

11. Return :math:`{val}{^{k}}`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{invocation}(\mathit{s},\, \mathit{fa},\, {\mathit{val}^{\mathit{n}}}) &=& \mathit{s} ; \mathit{f} ; {\mathit{val}^{\mathit{n}}}~(\mathsf{call}~\mathit{fa}) &\quad
     \mbox{if}~\mathit{m} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{func}~\epsilon,\; \\
     \mathsf{global}~\epsilon,\; \\
     \mathsf{table}~\epsilon,\; \\
     \mathsf{mem}~\epsilon,\; \\
     \mathsf{elem}~\epsilon,\; \\
     \mathsf{data}~\epsilon,\; \\
     \mathsf{export}~\epsilon \}\end{array} \\
    &&&\quad {\land}~\mathit{f} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{local}~\epsilon,\; \mathsf{module}~\mathit{m} \}\end{array} \\
    &&&\quad {\land}~(\mathit{s} ; \mathit{f}).\mathsf{func}[\mathit{fa}].\mathsf{code} = \mathsf{func}~\mathit{functype}~{\mathit{valtype}^\ast}~\mathit{expr} \\
    &&&\quad {\land}~\mathit{functype} = {\mathit{valtype}_{\mathit{param}}^{\mathit{n}}} \rightarrow {\mathit{valtype}_{\mathit{res}}^{\mathit{k}}} \\
   \end{array}
