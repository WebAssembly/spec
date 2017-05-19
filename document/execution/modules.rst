Modules
-------


.. _valid-externval:

External Typing
~~~~~~~~~~~~~~~

For the purpose of checking :ref:`external values <syntax-externval>` against :ref:`imports <syntax-import>`,
such values are classified by :ref:`external types <syntax-externtype>` via auxiliary typing rules.
These typing rules are specified relative to a :ref:`store <syntax-store>` :math:`S` in which the external value lives.

:math:`\FUNC~a`
...............

* The store entry :math:`S.\FUNCS[a]` must be a :ref:`function instance <syntax-funcinst>` :math:`\{\MODULE~m, \CODE~f\}`.

* Then :math:`\FUNC~a` is valid with :ref:`external type <syntax-externtype>` :math:`\FUNC~(m.\TYPES[f.\TYPE])`.

.. math::
   \frac{
     S.\FUNCS[a] = \{\MODULE~m, \CODE~f\}
   }{
     S \vdash \FUNC~a : \FUNC~(m.\TYPES[f.\TYPE])
   }


:math:`\TABLE~a`
................

* The store entry :math:`S.\TABLES[a]` must be a :ref:`table instance <syntax-tableinst>` :math:`\{\ELEM~(a^?)^n, \MAX~m^?\}`.

* Then :math:`\TABLE~a` is valid with :ref:`external type <syntax-externtype>` :math:`\TABLE~(\{\MIN~n, \MAX~m^?\}~\ANYFUNC)`.

.. math::
   \frac{
     S.\TABLES[a] = \{ \ELEM~(a^?)^n, \MAX~m^? \}
   }{
     S \vdash \TABLE~a : \TABLE~(\{\MIN~n, \MAX~m^?\}~\ANYFUNC)
   }


:math:`\MEM~a`
..............

* The store entry :math:`S.\MEMS[a]` must be a :ref:`memory instance <syntax-meminst>` :math:`\{\DATA~b^{n\cdot64\,\F{Ki}}, \MAX~m^?\}`, for some :math:`n`.

* Then :math:`\MEM~a` is valid with :ref:`external type <syntax-externtype>` :math:`\MEM~(\{\MIN~n, \MAX~m^?\})`.

.. math::
   \frac{
     S.\MEMS[a] = \{ \DATA~b^{n\cdot64\,\F{Ki}}, \MAX~m^? \}
   }{
     S \vdash \MEM~a : \MEM~\{\MIN~n, \MAX~m^?\}
   }


:math:`\GLOBAL~a`
.................

* The store entry :math:`S.\GLOBALS[a]` must be a :ref:`global instance <syntax-globalinst>` :math:`\{\VALUE~(t.\CONST~c), \MUT~\mut\}`.

* Then :math:`\GLOBAL~a` is valid with :ref:`external type <syntax-externtype>` :math:`\GLOBAL~(\mut~t)`.

.. math::
   \frac{
     S.\GLOBALS[a] = \{ \VALUE~(t.\CONST~c), \MUT~\mut \}
   }{
     S \vdash \GLOBAL~a : \GLOBAL~(\mut~t)
   }



.. _exec-import:
.. _match-externtype:

Import Matching
~~~~~~~~~~~~~~~

When :ref:`instantiating <exec-module>` a module,
:ref:`external values <syntax-externval>` must be provided whose :ref:`types <valid-externval>` are *matched* against the respective :ref:`external types <syntax-externtype>` classifying each import.
In some cases, this allows for a simple form of subtyping, as defined below.

.. _match-limits:

Limits
......

:ref:`Limits <syntax-limits>` :math:`\{ \MIN~n_1, \MAX~m_1^? \}` match limits :math:`\{ \MIN~n_2, \MAX~m_2^? \}` if and only if:

* :math:`n_1` is not smaller than :math:`n_2`.

* Either:

  * :math:`m_2^?` is empty.

* Or:

  * Both :math:`m_1^?` and :math:`m_2^?` are non-empty.

  * :math:`m_1` is not larger than :math:`m_2`.

.. math::
   \frac{
     n_1 \geq n_2
   }{
     \vdash \{ \MIN~n_1, \MAX~m_1^? \} \leq \{ \MIN~n_2, \MAX~\epsilon \}
   }
   \quad
   \frac{
     n_1 \geq n_2
     \qquad
     m_1 \leq m_2
   }{
     \vdash \{ \MIN~n_1, \MAX~m_1 \} \leq \{ \MIN~n_2, \MAX~m_2 \}
   }


Functions
.........

An :ref:`external type <syntax-externtype>` :math:`\FUNC~\functype_1` matches :math:`\FUNC~\functype_2` if and only if:

* Both :math:`\functype_1` and :math:`\functype_2` are the same.

.. math::
   \frac{
   }{
     \vdash \FUNC~\functype \leq \FUNC~\functype
   }


Tables
......

An :ref:`external type <syntax-externtype>` :math:`\TABLE~(\limits_1~\elemtype_1)` matches :math:`\TABLE~(\limits_2~\elemtype_2)` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

* Both :math:`\elemtype_1` and :math:`\elemtype_2` are the same.

.. math::
   \frac{
     \vdash \limits_1 \leq \limits_2
   }{
     \vdash \TABLE~(\limits_1~\elemtype) \leq \TABLE~(\limits_2~\elemtype)
   }


Memories
........

An :ref:`external type <syntax-externtype>` :math:`\MEM~\limits_1` matches :math:`\MEM~\limits_2` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

.. math::
   \frac{
     \vdash \limits_1 \leq \limits_2
   }{
     \vdash \MEM~\limits_1 \leq \MEM~\limits_2
   }


Globals
.......

An :ref:`external type <syntax-externtype>` :math:`\GLOBAL~\globaltype_1` matches :math:`\GLOBAL~\globaltype_2` if and only if:

* Both :math:`\globaltype_1` and :math:`\globaltype_2` are the same.

.. math::
   \frac{
   }{
     \vdash \GLOBAL~\globaltype \leq \GLOBAL~\globaltype
   }


.. _alloc:

Allocation
~~~~~~~~~~

New instances of :ref:`functions <syntax-funcinst>`, :ref:`tables <syntax-tableinst>`, :ref:`memories <syntax-meminst>`, :ref:`globals <syntax-globalinst>`, and :ref:`modules <syntax-moduleinst>` are *allocated* in a :ref:`store <syntax-store>` :math:`S`, as defined by the following auxiliary functions.


.. _alloc-func:

:ref:`Functions <syntax-funcinst>`
..................................

1. Let :math:`\func` be the :ref:`function <syntax-func>` to allocate and :math:`\moduleinst` its :ref:`module instance <syntax-moduleinst>`.

2. Let :math:`a` be the first free :ref:`function address <syntax-funcaddr>` in :math:`S`.

3. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`\{ \MODULE~\moduleinst, \CODE~\func \}`.

4. Append :math:`\funcinst` to the |FUNCS| of :math:`S`.

5. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocfunc(S, \func, \moduleinst) &=& S', \funcaddr \\[1ex]
   \mbox{where:} \hfill \\
   \funcaddr &=& |S.\FUNCS| \\
   \funcinst &=& \{ \MODULE~\moduleinst, \CODE~\func \} \\
   S' &=& S \compose \{\FUNCS~\tableinst\} \\
   \end{array}

.. _alloc-table:

:ref:`Tables <syntax-tableinst>`
................................

1. Let :math:`\table` be the :ref:`table <syntax-table>` to allocate.

2. Let :math:`\{\MIN~n, \MAX~m^?\}~\elemtype` be the :ref:`table type <syntax-tabletype>` :math:`\table.\TYPE`.

3. Let :math:`a` be the first free :ref:`table address <syntax-tableaddr>` in :math:`S`.

4. Let :math:`\tableinst` be the :ref:`table instance <syntax-tableinst>` :math:`\{ \ELEM~(\epsilon)^n, \MAX~m^? \}` with :math:`n` empty elements.

5. Append :math:`\tableinst` to the |TABLES| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \alloctable(S, \table) &=& S', \tableaddr \\[1ex]
   \mbox{where:} \hfill \\
   \table.\TYPE &=& \{\MIN~n, \MAX~m^?\}~\elemtype \\
   \tableaddr &=& |S.\TABLES| \\
   \tableinst &=& \{ \ELEM~(\epsilon)^n, \MAX~m^? \} \\
   S' &=& S \compose \{\TABLES~\tableinst\} \\
   \end{array}

.. _alloc-mem:

:ref:`Memories <syntax-meminst>`
................................

1. Let :math:`\mem` be the :ref:`memory <syntax-mem>` to allocate.

2. Let :math:`\{\MIN~n, \MAX~m^?\}` be the :ref:`table type <syntax-memtype>` :math:`\mem.\TYPE`.

3. Let :math:`a` be the first free :ref:`memory address <syntax-memaddr>` in :math:`S`.

4. Let :math:`\meminst` be the :ref:`memory instance <syntax-meminst>` :math:`\{ \DATA~(\hex{00})^{n \cdot 64\,\F{Ki}}, \MAX~m^? \}` that contains :math:`n` pages of zeroed bytes.

5. Append :math:`\meminst` to the |MEMS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocmem(S, \mem) &=& S', \memaddr \\[1ex]
   \mbox{where:} \hfill \\
   \mem.\TYPE &=& \{\MIN~n, \MAX~m^?\} \\
   \memaddr &=& |S.\MEMS| \\
   \meminst &=& \{ \DATA~(\hex{00})^{n \cdot 64\,\F{Ki}}, \MAX~m^? \} \\
   S' &=& S \compose \{\MEMS~\meminst\} \\
   \end{array}

.. _alloc-global:

:ref:`Globals <syntax-globalinst>`
..................................

1. Let :math:`\global` be the :ref:`global <syntax-global>` to allocate.

2. Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`\global.\TYPE`.

3. Let :math:`a` be the first free :ref:`global address <syntax-globaladdr>` in :math:`S`.

4. Let :math:`\globalinst` be the :ref:`global instance <syntax-globalinst>` :math:`\{ \VALUE~(t.\CONST~0), \MUT~\mut \}` whose contents is a zero :ref:`value <syntax-val>` of :ref:`value type <syntax-valtype>` :math:`t`.

5. Append :math:`\globalinst` to the |GLOBALS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocglobal(S, \global) &=& S', \globaladdr \\[1ex]
   \mbox{where:} \hfill \\
   \global.\TYPE &=& \mut~t \\
   \globaladdr &=& |S.\GLOBALS| \\
   \globalinst &=& \{ \VALUE~(t.\CONST~0), \MUT~\mut \} \\
   S' &=& S \compose \{\GLOBALS~\globalinst\} \\
   \end{array}

.. _alloc-module:

:ref:`Modules <syntax-moduleinst>`
..................................

The allocation function for :ref:`modules <syntax-module>` requires a suitable list of :ref:`external values <syntax-externval>` that are assumed to match the :ref:`import <syntax-import>` vector of the module.

1. Let :math:`\module` be the :ref:`module <syntax-module>` to allocate and :math:`\externval_{\F{im}}^\ast` the vector of :ref:`external values <syntax-externval>` providing the module's imports.

2. Let :math:`\funcaddr_{\F{mod}}^\ast` be the list of :ref:`function addresses <syntax-funcaddr>` extracted from :math:`\externval_{\F{im}}^\ast`.

3. Let :math:`\tableaddr_{\F{mod}}^\ast` be the list of :ref:`table addresses <syntax-tableaddr>` extracted from :math:`\externval_{\F{im}}^\ast`.

4. Let :math:`\memaddr_{\F{mod}}^\ast` be the list of :ref:`memory addresses <syntax-memaddr>` extracted from :math:`\externval_{\F{im}}^\ast`.

5. Let :math:`\globaladdr_{\F{mod}}^\ast` be the list of :ref:`global addresses <syntax-globaladdr>` extracted from :math:`\externval_{\F{im}}^\ast`.

6. For each :ref:`function <syntax-func>` :math:`\func_i` in :math:`\module.\FUNCS`, do:

   a. Let :math:`\funcaddr_i` be the :ref:`function address <syntax-funcaddr>` resulting from :ref:`allocating <alloc-func>` :math:`\func_i` for the :ref:`\module instance <syntax-moduleinst>` :math:`\moduleinst` defined below.

   b. Append :math:`\funcaddr_i` to :math:`\funcaddr_{\F{mod}}^\ast`.

7. For each :ref:`table <syntax-table>` :math:`\table_i` in :math:`\module.\TABLES`, do:

   a. Let :math:`\tableaddr_i` be the :ref:`table address <syntax-tableaddr>` resulting from :ref:`allocating <alloc-table>` :math:`\table_i`.

   b. Append :math:`\tableaddr_i` to :math:`\tableaddr_{\F{mod}}^\ast`.

8. For each :ref:`memory <syntax-mem>` :math:`\mem_i` in :math:`\module.\MEMS`, do:

   a. Let :math:`\memaddr_i` be the :ref:`memory address <syntax-memaddr>` resulting from :ref:`allocating <alloc-mem>` :math:`\mem_i`.

   b. Append :math:`\memaddr_i` to :math:`\memaddr_{\F{mod}}^\ast`.

9. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\GLOBALS`, do:

   a. Let :math:`\globaladdr_i` be the :ref:`global address <syntax-globaladdr>` resulting from :ref:`allocating <alloc-global>` :math:`\global_i`.

   b. Append :math:`\globaladdr_i` to :math:`\globaladdr_{\F{mod}}^\ast`.

10. Let :math:`\exportinst^\ast` be an empty list of :ref:`export instances <syntax-exportinst>`

11. For each :ref:`export <syntax-export>` :math:`\export_i` in :math:`\module.\EXPORTS`, do:

    a. If :math:`\export_i` is a function export for :ref:`function index <syntax-funcidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\FUNC~(\funcaddr_{\F{mod}}^\ast[x])`.

    b. Else, if :math:`\export_i` is a table export for :ref:`table index <syntax-tableidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\TABLE~(\tableaddr_{\F{mod}}^\ast[x])`.

    c. Else, if :math:`\export_i` is a memory export for :ref:`memory index <syntax-memidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\MEM~(\memaddr_{\F{mod}}^\ast[x])`.

    d. Else, if :math:`\export_i` is a global export for :ref:`global index <syntax-globalidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\GLOBAL~(\globaladdr_{\F{mod}}^\ast[x])`.

    e. Let :math:`\exportinst_i` be the :ref:`export instance <syntax-exportinst>` :math:`\{\NAME~(\export_i.\NAME), \VALUE~\externval_i\}`.

    f. Append :math:`\exportinst_i` to :math:`\exportinst^\ast`.

12. Let :math:`\moduleinst` be the :ref:`module instance <syntax-moduleinst>` :math:`\{\TYPES~(\module.\TYPES), \FUNCS~\funcaddr_{\F{mod}}^\ast, \TABLES~\tableaddr_{\F{mod}}^\ast, \MEMS~\memaddr_{\F{mod}}^\ast, \GLOBALS~\globaladdr_{\F{mod}}^\ast, \EXPORTS~\exportinst^\ast\}`.

6. Return :math:`\moduleinst`.


.. math::
   \begin{array}{rlll}
   \allocmodule(S, \module, \externval_{\F{im}}^\ast) &=& S', \moduleinst \\[1ex]
   \mbox{where:} \hfill \\
   \end{array}

.. math::
   \begin{array}{rlll}
   \moduleinst &=& \{~
     \begin{array}[t]{@{}l@{}}
     \TYPES~\module.\TYPES, \\
     \FUNCS~\funcs(\externval_{\F{im}}^\ast)~\funcaddr^\ast, \\
     \TABLES~\tables(\externval_{\F{im}}^\ast)~\tableaddr^\ast, \\
     \MEMS~\mems(\externval_{\F{im}}^\ast)~\memaddr^\ast, \\
     \GLOBALS~\globals(\externval_{\F{im}}^\ast)~\globaladdr^\ast, \\
     \EXPORTS~\exportinst^\ast ~\}
     \end{array} \\[1ex]
   S_1, \funcaddr^\ast &=& \allocfunc^\ast(S, \module.\FUNCS, \moduleinst) \\
   S_2, \tableaddr^\ast &=& \alloctable^\ast(S_1, \module.\TABLES) \\
   S_3, \memaddr^\ast &=& \allocmem^\ast(S_2, \module.\MEMS) \\
   S', \globaladdr^\ast &=& \allocglobal^\ast(S_3, \module.\GLOBALS) \\[1ex]
   \exportinst^\ast &=& \{ \NAME~(\export.\NAME), \VALUE~\externval_{\F{ex}} \}^\ast
     & (\export^\ast = \module.\EXPORTS) \\
   \funcs(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\FUNCS[x])^\ast
     & (x^\ast = \funcs(\module.\EXPORTS)) \\
   \tables(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\TABLES[x])^\ast
     & (x^\ast = \tables(\module.\EXPORTS)) \\
   \mems(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MEMS[x])^\ast
     & (x^\ast = \mems(\module.\EXPORTS)) \\
   \globals(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\GLOBALS[x])^\ast
     & (x^\ast = \globals(\module.\EXPORTS)) \\
   \end{array}

Here, the notation :math:`\F{allocX}^\ast` is shorthand for multiple :ref:`allocations <alloc>` of object kind :math:`X`, defined as follows:

.. math::
   \begin{array}{rlll}
   \F{allocX}^\ast(S_0, X^n, \dots) &=& S_n, a^n \\[1ex]
   \mbox{where for all $i < n$:} \hfill \\
   S_{i+1}, a^n[i] &=& \F{allocX}(S_i, X^n[i], \dots)
   \end{array}

.. note::
   The definition of module allocation is mutually recursive with the allocation of its associated functions, because the resulting module instance :math:`\moduleinst` is passed to the function allocator as an argument, in order to form the necessary closures.
   In an implementation, this recursion is easily unraveled by mutating one or the other in a secondary step.

   The export instances in the formal definition are also formed by reference to the resulting module instance :math:`\moduleinst`.
   However, that is merely a convenient device to succinctly look up the external values by :ref:`index <syntax-index>` relative to their respective :ref:`index space <syntax-index>`.


.. _instantiation:
.. _exec-module:
.. index:: ! instantiation, module, instance, store

Instantiation
~~~~~~~~~~~~~

Given a :ref:`store <syntax-store>` :math:`S` and a :ref:`module <syntax-module>` :math:`m` is instantiated with a list of :ref:`external values <syntax-externval>` :math:`\externval^\ast` supplying the required imports as follows.

.. todo::
   Work in progress

.. math::
   \frac{
   }{
     S; \INSTANTIATE~\module~\externval^n \stepto S; \TRAP
   }

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     \module.\IMPORTS = \externtype^n
     \qquad
     \module.\GLOBALS = \global^\ast
     \qquad
     \module.\ELEM = \elem^\ast
     \qquad
     \module.\DATA = \data^\ast
     \qquad
     \module.\START = \start^?
     \\
     (\vdash \externval : \externtype)^n
     \qquad
     \F{allocmodule}(S, \module, \externval^n) = S', \moduleinst
     \qquad
     F = \{ \MODULE~\moduleinst, \LOCALS~\epsilon \}
     \\
     (S'; F; \global.\INIT \stepto^\ast v)^\ast
     \qquad
     (S'; F; \elem.\OFFSET \stepto^\ast \I32.\CONST~\X{eo})^\ast
     \qquad
     (S'; F; \data.\OFFSET \stepto^\ast \I32.\CONST~\X{do})^\ast
     \\
     (\globalidx = i + |\moduleinst.\GLOBALS| - |\module.\GLOBALS|)_i^\ast
     \qquad
     (\globaladdr = \moduleinst.\GLOBALS[\globalidx])^\ast
     \\
     (\tableaddr = \moduleinst.\TABLES[\elem.\TABLE])^\ast
     \qquad
     (\globaladdr = \moduleinst.\MEMS[\data.\MEM])^\ast
     \qquad
     (\funcinst = \moduleinst.\FUNCS[\start.\FUNC])^?
     \\
     (\X{eo} + |\elem.\INIT| \leq |S'.\TABLES[\tableaddr]|)^\ast
     \qquad
     (\X{do} + |\data.\INIT| \leq |S'.\MEMS[\memaddr]|)^\ast
     \end{array}
   }{
     S; \INSTANTIATE~\module~\externval^n \stepto S';
       \begin{array}[t]{@{}l@{}}
       (\INITGLOBAL~\globaladdr~v)^\ast \\
       (\INITTABLE~\tableaddr~\X{eo}~\moduleinst~\elem.\INIT)^\ast \\
       (\INITMEM~\memaddr~\X{do}~\data.\INIT)^\ast \\
       (\INVOKE~\funcinst)^? \\
       \moduleinst \\
       \end{array}
   }

.. math::
   \frac{
     S' = S \with \GLOBALS[\globaladdr] = v
   }{
     S; \INITGLOBAL~\globaladdr~v \stepto S'; \epsilon
   }

.. math::
   \frac{
   }{
     S; \INITTABLE~\tableaddr~o~\moduleinst~\epsilon \stepto S; \epsilon
   }

.. math::
   \frac{
     S' = S \with \TABLES[\tableaddr][o] = \moduleinst.\FUNCS[x_0]
   }{
     S; \INITTABLE~\tableaddr~o~\moduleinst~(x_0~x^\ast) \stepto S'; \INITTABLE~\tableaddr~(o+1)~\moduleinst~x^\ast
   }

.. math::
   \frac{
   }{
     S; \INITMEM~\memaddr~o~\epsilon \stepto S; \epsilon
   }

.. math::
   \frac{
     S' = S \with \MEMS[\memaddr][o] = b_0
   }{
     S; \INITMEM~\memaddr~o~(b_0~b^\ast) \stepto S'; \INITMEM~\memaddr~(o+1)~b^\ast
   }
